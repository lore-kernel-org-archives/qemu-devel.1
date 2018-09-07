Received: from eggs.gnu.org ([2001:4830:134:3::10]:33879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fyEye-0003WH-OB
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 07:31:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fyEyZ-0000mq-4C
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 07:31:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45816 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fyEyY-0000gO-TR
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 07:30:59 -0400
Date: Fri, 7 Sep 2018 13:30:54 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180907133054.2ca10203@redhat.com>
In-Reply-To: <e0d0c3ee-b690-d668-02fa-3ac2ff3c5259@redhat.com>
References: <1536238314-108139-1-git-send-email-imammedo@redhat.com>
	<e0d0c3ee-b690-d668-02fa-3ac2ff3c5259@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] qga: ignore non present cpus when
 handling qmp_guest_get_vcpus()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

On Thu, 6 Sep 2018 16:13:52 +0200
Laszlo Ersek <lersek@redhat.com> wrote:

> On 09/06/18 14:51, Igor Mammedov wrote:
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
> > v2:
> >   do not create CPU entry if cpu isn't present
> >   (Laszlo Ersek <lersek@redhat.com>)
> > ---
> >  qga/commands-posix.c | 115 ++++++++++++++++++++++++++-------------------------
> >  1 file changed, 59 insertions(+), 56 deletions(-)
> >
> > diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> > index 37e8a2d..42d30f0 100644
> > --- a/qga/commands-posix.c
> > +++ b/qga/commands-posix.c
> > @@ -2035,61 +2035,56 @@ static long sysconf_exact(int name, const char *name_str, Error **errp)
> >   * Written members remain unmodified on error.
> >   */
> >  static void transfer_vcpu(GuestLogicalProcessor *vcpu, bool sys2vcpu,
> > -                          Error **errp)
> > +                          char *dirpath, Error **errp)
> >  {
> > -    char *dirpath;
> > +    int fd;
> > +    int res;
> >      int dirfd;
> > +    static const char fn[] = "online";
> >
> > -    dirpath = g_strdup_printf("/sys/devices/system/cpu/cpu%" PRId64 "/",
> > -                              vcpu->logical_id);
> >      dirfd = open(dirpath, O_RDONLY | O_DIRECTORY);
> >      if (dirfd == -1) {
> >          error_setg_errno(errp, errno, "open(\"%s\")", dirpath);
> > -    } else {
> > -        static const char fn[] = "online";
> > -        int fd;
> > -        int res;
> > -
> > -        fd = openat(dirfd, fn, sys2vcpu ? O_RDONLY : O_RDWR);
> > -        if (fd == -1) {
> > -            if (errno != ENOENT) {
> > -                error_setg_errno(errp, errno, "open(\"%s/%s\")", dirpath, fn);
> > -            } else if (sys2vcpu) {
> > -                vcpu->online = true;
> > -                vcpu->can_offline = false;
> > -            } else if (!vcpu->online) {
> > -                error_setg(errp, "logical processor #%" PRId64 " can't be "
> > -                           "offlined", vcpu->logical_id);
> > -            } /* otherwise pretend successful re-onlining */
> > -        } else {
> > -            unsigned char status;
> > -
> > -            res = pread(fd, &status, 1, 0);
> > -            if (res == -1) {
> > -                error_setg_errno(errp, errno, "pread(\"%s/%s\")", dirpath, fn);
> > -            } else if (res == 0) {
> > -                error_setg(errp, "pread(\"%s/%s\"): unexpected EOF", dirpath,
> > -                           fn);
> > -            } else if (sys2vcpu) {
> > -                vcpu->online = (status != '0');
> > -                vcpu->can_offline = true;
> > -            } else if (vcpu->online != (status != '0')) {
> > -                status = '0' + vcpu->online;
> > -                if (pwrite(fd, &status, 1, 0) == -1) {
> > -                    error_setg_errno(errp, errno, "pwrite(\"%s/%s\")", dirpath,
> > -                                     fn);
> > -                }
> > -            } /* otherwise pretend successful re-(on|off)-lining */
> > +        return;
> > +    }
> >
> > -            res = close(fd);
> > -            g_assert(res == 0);
> > -        }
> > +    fd = openat(dirfd, fn, sys2vcpu ? O_RDONLY : O_RDWR);
> > +    if (fd == -1) {
> > +        if (errno != ENOENT) {
> > +            error_setg_errno(errp, errno, "open(\"%s/%s\")", dirpath, fn);
> > +        } else if (sys2vcpu) {
> > +            vcpu->online = true;
> > +            vcpu->can_offline = false;
> > +        } else if (!vcpu->online) {
> > +            error_setg(errp, "logical processor #%" PRId64 " can't be "
> > +                       "offlined", vcpu->logical_id);
> > +        } /* otherwise pretend successful re-onlining */
> > +    } else {
> > +        unsigned char status;
> > +
> > +        res = pread(fd, &status, 1, 0);
> > +        if (res == -1) {
> > +            error_setg_errno(errp, errno, "pread(\"%s/%s\")", dirpath, fn);
> > +        } else if (res == 0) {
> > +            error_setg(errp, "pread(\"%s/%s\"): unexpected EOF", dirpath,
> > +                       fn);
> > +        } else if (sys2vcpu) {
> > +            vcpu->online = (status != '0');
> > +            vcpu->can_offline = true;
> > +        } else if (vcpu->online != (status != '0')) {
> > +            status = '0' + vcpu->online;
> > +            if (pwrite(fd, &status, 1, 0) == -1) {
> > +                error_setg_errno(errp, errno, "pwrite(\"%s/%s\")", dirpath,
> > +                                 fn);
> > +            }
> > +        } /* otherwise pretend successful re-(on|off)-lining */
> >
> > -        res = close(dirfd);
> > +        res = close(fd);
> >          g_assert(res == 0);
> >      }
> >
> > -    g_free(dirpath);
> > +    res = close(dirfd);
> > +    g_assert(res == 0);
> >  }
> >
> >  GuestLogicalProcessorList *qmp_guest_get_vcpus(Error **errp)
> > @@ -2107,17 +2102,21 @@ GuestLogicalProcessorList *qmp_guest_get_vcpus(Error **errp)
> >      while (local_err == NULL && current < sc_max) {
> >          GuestLogicalProcessor *vcpu;
> >          GuestLogicalProcessorList *entry;
> > -
> > -        vcpu = g_malloc0(sizeof *vcpu);
> > -        vcpu->logical_id = current++;
> > -        vcpu->has_can_offline = true; /* lolspeak ftw */
> > -        transfer_vcpu(vcpu, true, &local_err);
> > -
> > -        entry = g_malloc0(sizeof *entry);
> > -        entry->value = vcpu;
> > -
> > -        *link = entry;
> > -        link = &entry->next;
> > +        int64_t id = current++;
> > +        char *path = g_strdup_printf("/sys/devices/system/cpu/cpu%" PRId64 "/",
> > +                                     id);
> > +
> > +        if (g_file_test(path, G_FILE_TEST_EXISTS)) {
> > +            vcpu = g_malloc0(sizeof *vcpu);
> > +            vcpu->logical_id = id;
> > +            vcpu->has_can_offline = true; /* lolspeak ftw */
> > +            transfer_vcpu(vcpu, true, path, &local_err);
> > +            entry = g_malloc0(sizeof *entry);
> > +            entry->value = vcpu;
> > +            *link = entry;
> > +            link = &entry->next;
> > +        }
> > +        g_free(path);
> >      }
> >
> >      if (local_err == NULL) {
> > @@ -2138,7 +2137,11 @@ int64_t qmp_guest_set_vcpus(GuestLogicalProcessorList *vcpus, Error **errp)
> >
> >      processed = 0;
> >      while (vcpus != NULL) {
> > -        transfer_vcpu(vcpus->value, false, &local_err);
> > +        char *path = g_strdup_printf("/sys/devices/system/cpu/cpu%" PRId64 "/",
> > +                                     vcpus->value->logical_id);
> > +
> > +        transfer_vcpu(vcpus->value, false, path, &local_err);
> > +        g_free(path);
> >          if (local_err != NULL) {
> >              break;
> >          }
> >  
> 
> This looks good. The things that I could raise, if I wanted to annoy you
> :) , are:
> 
> - transfer_vcpu() should take "const char *dirpath", not just "char
>   *dirpath",
> 
> - there's a small window between g_file_test() and open() -- not sure if
>   we care, but it catches my eye,
Even if dirpath is opened cpu removal might still race vs accesses inside that directory.
I'd say it's not worth effort to make race free,
just don't use damn thing with real unplug.

 
> - the pathname formatting is now duplicated.
Yep, is wasn't worth adding helper func since it just increases amount of code.
But I don't really care can add it if I respin patch.

> How about a helper function like this:
> 
> > static int open_cpu_dir(int64_t cpu_id, Error **errp)
> > {
> >   char *dirpath;
> >   int rc;
> >
> >   dirpath = g_strdup_printf("/sys/devices/system/cpu/cpu%" PRId64 "/", cpu_id);
> >   rc = open(dirpath, O_RDONLY | O_DIRECTORY);
> >   if (rc == -1) {
> >     rc = -errno;
> >     error_setg_errno(errp, errno, "open(\"%s\")", dirpath);
> >   }
> >   g_free(dirpath);
> >   return rc;
> > }
> 
> Then you can:
> 
> (1) remove g_file_test() from qmp_guest_get_vcpus(),
> 
> (2) remove open() from transfer_vcpu(),
> 
> (3) take a dirfd in transfer_vcpu(), rather than a dirpath,
I've considered it, but if we don't pass dirpath to transfer_vcpu()
we loose on path in error messages hence dropped whole idea as excessive.


> (4) distinguish "success" (non-negative), (-ENOENT), and "other error"
>     (negative) in qmp_guest_get_vcpus(), and act accordingly (call
>     transfer_vcpu(), skip, or bail for good; respectively),
> 
> (5) eliminate the formatting from qmp_guest_set_vcpus().
> 
> I think the only quirk is that, when skipping in (4), local_err has to
> be freed with error_free(), and re-set to NULL.
> 
> What do you think? (If it's too much work for little gain, I'm ready to
> ACK v2 as well; don't want to waste your time.)
I doesn't matter to me. Since you happen to be original author,
I'll deffer to your opinion.


> Thanks,
> Laszlo
> 
