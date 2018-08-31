Received: from eggs.gnu.org ([2001:4830:134:3::10]:58564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fveMR-0002kZ-RD
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 04:00:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fveMO-0000Xa-K7
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 04:00:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36928 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fveMO-0000Wp-DZ
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 04:00:52 -0400
Date: Fri, 31 Aug 2018 10:00:46 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180831100046.3467d1fd@redhat.com>
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
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, Drew Jones <drjones@redhat.com>, libvir-list@redhat.com

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
> 
> Originally these guest agent commands (both getting and setting) were
> meant to be used in the absence of real VCPU hot[un]plug, as a fallback
> / place-holder.
> 
> If the latter (= real VCPU hot(un)plug) works, then these guest agent
> commands shouldn't be used at all.
Technically there isn't reasons for "get" not to work in sparse  usecase
hence the patch.

> Drew, do I remember correctly? ... The related RHBZ is
> <https://bugzilla.redhat.com/show_bug.cgi?id=924684>. (It's a private
> one, and I'm not at liberty to open it up, so my apologies to non-RH folks.)
> 
> Anyway, given that "set" should be a subset of the "get" return value
> (as documented in the command schema), if we fix up "get" to work with
> sparse topologies, then "set" should work at once.
>
> However... as far as I understand, this change will allow
> qmp_guest_get_vcpus() to produce a GuestLogicalProcessor object for the
> missing (hot-unplugged) VCPU, with the following contents:
> - @logical-id: populated by the loop,
> - @online: false (from g_malloc0()),
> - @can-offline: present (from the loop), and false (from g_malloc0()).
> 
> The smaller problem with this might be that "online==false &&
> can-offline==false" is nonsensical and has never been returned before. I
> don't know how higher level apps will react.
> 
> The larger problem might be that a higher level app could simply copy
> this output structure into the next "set" call unchanged, and then that
> "set" call will fail.
Libvirt it seems that survives such outrageous output

> I wonder if, instead of this patch, we should rework
> qmp_guest_get_vcpus(), to silently skip processors for which this
> dirpath ENOENT condition arises (i.e., return a shorter list of
> GuestLogicalProcessor objects).

> But, again, I wouldn't mix this guest agent command with real VCPU
> hot(un)plug in the first place. The latter is much-much better, so if
> it's available, use that exclusively?
Agreed,

Maybe we can block invalid usecase on libvirt side with a more clear
error message as libvirt sort of knows that sparse cpus are supported.

> 
> Thanks,
> Laszlo
