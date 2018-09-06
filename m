Received: from eggs.gnu.org ([2001:4830:134:3::10]:57582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fxqv8-0000HR-Tg
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 05:49:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fxqv5-0003c0-M8
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 05:49:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51674 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fxqv5-0003as-Ep
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 05:49:47 -0400
Date: Thu, 6 Sep 2018 11:49:45 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180906114945.1acd0b8e@redhat.com>
In-Reply-To: <38b3347b-8923-26e9-82a4-f69002262767@redhat.com>
References: <1535630903-146863-1-git-send-email-imammedo@redhat.com>
	<38b3347b-8923-26e9-82a4-f69002262767@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qga: ignore non present cpus when handling
 qmp_guest_get_vcpus()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, Drew Jones <drjones@redhat.com>, mdroth@linux.vnet.ibm.com

On Thu, 30 Aug 2018 17:51:13 +0200
Laszlo Ersek <lersek@redhat.com> wrote:

> +Drew
> 
> On 08/30/18 14:08, Igor Mammedov wrote:
> > If VM has VCPUs plugged sparselly (for example a VM started with
> > 3 VCPUs (cpu0, cpu1 and cpu2) and then cpu1 was hotunplugged so
> > only cpu0 and cpu2 are present), QGA will rise a error
> >   error: internal error: unable to execute QEMU agent command 'guest-get-vcpus':
> >   open("/sys/devices/system/cpu/cpu1/"): No such file or directory
> > when
> >   virsh vcpucount FOO --guest
> > is executed.
> > Fix it by ignoring non present CPUs when fetching CPUs status from sysfs.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  qga/commands-posix.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> > index 37e8a2d..2929872 100644
> > --- a/qga/commands-posix.c
> > +++ b/qga/commands-posix.c
> > @@ -2044,7 +2044,9 @@ static void transfer_vcpu(GuestLogicalProcessor *vcpu, bool sys2vcpu,
> >                                vcpu->logical_id);
> >      dirfd = open(dirpath, O_RDONLY | O_DIRECTORY);
> >      if (dirfd == -1) {
> > -        error_setg_errno(errp, errno, "open(\"%s\")", dirpath);
> > +        if (!(sys2vcpu && errno == ENOENT)) {
> > +            error_setg_errno(errp, errno, "open(\"%s\")", dirpath);
> > +        }
> >      } else {
> >          static const char fn[] = "online";
> >          int fd;
> >   
[...]
 
> I wonder if, instead of this patch, we should rework
> qmp_guest_get_vcpus(), to silently skip processors for which this
> dirpath ENOENT condition arises (i.e., return a shorter list of
> GuestLogicalProcessor objects).
would something like this on top of this patch do?

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 2929872..990bb80 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -2114,12 +2114,14 @@ GuestLogicalProcessorList *qmp_guest_get_vcpus(Error **errp)
         vcpu->logical_id = current++;
         vcpu->has_can_offline = true; /* lolspeak ftw */
         transfer_vcpu(vcpu, true, &local_err);
-
-        entry = g_malloc0(sizeof *entry);
-        entry->value = vcpu;
-
-        *link = entry;
-        link = &entry->next;
+        if (errno == ENOENT) {
+            g_free(vcpu);
+        } else {
+            entry = g_malloc0(sizeof *entry);
+            entry->value = vcpu;
+            *link = entry;
+            link = &entry->next;
+        }
     }
 
     if (local_err == NULL) {

[...]
