Received: from eggs.gnu.org ([2001:4830:134:3::10]:48637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jannh@google.com>) id 1fpI4U-0007GK-CX
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 15:00:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jannh@google.com>) id 1fpI4T-0001mX-Ex
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 15:00:06 -0400
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:35096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jannh@google.com>) id 1fpI4T-0001m6-7f
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 15:00:05 -0400
Received: by mail-oi0-x232.google.com with SMTP id m11-v6so29215826oic.2
	for <qemu-devel@nongnu.org>; Mon, 13 Aug 2018 12:00:04 -0700 (PDT)
MIME-Version: 1.0
From: Jann Horn <jannh@google.com>
Date: Mon, 13 Aug 2018 20:59:36 +0200
Message-ID: <CAG48ez2bTiQArW0XHA3ngmMTBoDevS6QZQghbAUM_+8ZYBrAOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] seccomp blacklist is not applied to all threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Red Hat Product Security <secalert@redhat.com>

Hi!

I have noticed that when a QEMU build from git master is started with
"-seccomp on", the seccomp policy is only applied to the main thread,
the vcpu worker thread and the VNC thread (I'm using VNC in my
config); the seccomp policy is not applied to e.g. the RCU thread
because it is created before the seccomp policy is applied and
SECCOMP_FILTER_FLAG_TSYNC isn't used. In practice, this makes the
seccomp policy essentially useless. You'll probably want to add
something like seccomp_attr_set(ctx, SCMP_FLTATR_CTL_TSYNC, 1) for
systems with kernel >=3.17; if you have to support seccomp on older
kernels, you'll have to either construct the other threads after
initializing seccomp or manually activate seccomp on those threads.


This shows up in strace as follows:
$ strace -f -e trace=seccomp,clone,prctl
x86_64-softmmu/qemu-system-x86_64 -enable-kvm -drive
file=isos/debian-live-8.7.1-amd64-standard.iso,format=raw -m 4G
-sandbox on -name testvm,debug-threads=on
clone(child_stack=0x7f199af49bf0,
flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
parent_tidptr=0x7f199af4a9d0, tls=0x7f199af4a700,
child_tidptr=0x7f199af4a9d0) = 10948
strace: Process 10948 attached
[pid 10947] prctl(PR_MCE_KILL, PR_MCE_KILL_SET, PR_MCE_KILL_EARLY, 0, 0) = 0
[pid 10947] clone(child_stack=0x7f199a748bf0,
flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
parent_tidptr=0x7f199a7499d0, tls=0x7f199a749700,
child_tidptr=0x7f199a7499d0) = 10949
strace: Process 10949 attached
[pid 10947] prctl(PR_SET_TIMERSLACK, 1) = 0
[pid 10947] prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0) = 0
[pid 10947] seccomp(SECCOMP_SET_MODE_STRICT, 1, NULL) = -1 EINVAL
(Invalid argument)
[pid 10947] seccomp(SECCOMP_SET_MODE_FILTER, 0, {len=39,
filter=0x55a968927830}) = 0
[pid 10947] clone(strace: Process 10950 attached
child_stack=0x7f1999d65bf0,
flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
parent_tidptr=0x7f1999d669d0, tls=0x7f1999d66700,
child_tidptr=0x7f1999d669d0) = 10950
[pid 10950] prctl(PR_SET_NAME, "CPU 0/KVM") = 0
[pid 10947] clone(strace: Process 10952 attached
child_stack=0x7f1993bfebf0,
flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
parent_tidptr=0x7f1993bff9d0, tls=0x7f1993bff700,
child_tidptr=0x7f1993bff9d0) = 10952
[pid 10952] prctl(PR_SET_NAME, "worker") = 0
[pid 10947] clone(strace: Process 10953 attached
child_stack=0x7f19933fdbf0,
flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
parent_tidptr=0x7f19933fe9d0, tls=0x7f19933fe700,
child_tidptr=0x7f19933fe9d0) = 10953
[pid 10953] prctl(PR_SET_NAME, "vnc_worker") = 0
VNC server running on ::1:5900
[pid 10952] +++ exited with 0 +++


Checking in procfs confirms that two of the threads aren't sandboxed:

$ for task in /proc/10947/task/*; do cat $task/comm; grep Seccomp
$task/status; done
qemu-system-x86
Seccomp: 2
qemu-system-x86
Seccomp: 0
qemu-system-x86
Seccomp: 0
CPU 0/KVM
Seccomp: 2
vnc_worker
Seccomp: 2
