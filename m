Received: from eggs.gnu.org ([2001:4830:134:3::10]:37366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVPTo-0006bQ-M0
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 17:47:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVPTj-0004WX-Ok
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 17:47:32 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVPTj-0004WC-Jf
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 17:47:27 -0400
Received: by mail-qk0-f179.google.com with SMTP id d78so36141498qkb.1
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 14:47:27 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170712162550.8061-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bc2c99e9-3449-be02-bee1-b557e959fdb7@amsat.org>
Date: Wed, 12 Jul 2017 18:46:23 -0300
MIME-Version: 1.0
In-Reply-To: <20170712162550.8061-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Don't enable networking as a side-effect
 of DEBUG=1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

Hi Alex, Fam,

I wanted to try this patch but got:

$ make docker-test-quick@centos6 NETWORK=1
   BUILD   centos6
The command '/bin/sh -c yum install -y epel-release' returned a non-zero 
code: 139
Traceback (most recent call last):
   File "./tests/docker/docker.py", line 382, in <module>
     sys.exit(main())
   File "./tests/docker/docker.py", line 379, in main
     return args.cmdobj.run(args, argv)
   File "./tests/docker/docker.py", line 301, in run
     extra_files_cksum=cksum)
   File "./tests/docker/docker.py", line 185, in build_image
     quiet=quiet)
   File "./tests/docker/docker.py", line 123, in _do_check
     return subprocess.check_call(self._command + cmd, **kwargs)
   File "/usr/lib/python2.7/subprocess.py", line 186, in check_call
     raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['docker', 'build', '-t', 
'qemu:centos6', '-f', '/tmp/docker_buildIrIR2w/tmpxMPjZu.docker', 
'--build-arg=http_proxy=http://172.17.0.1:3142/', 
'/tmp/docker_buildIrIR2w']' returned non-zero exit status 139
tests/docker/Makefile.include:47: recipe for target 
'docker-image-centos6' failed
make: *** [docker-image-centos6] Error 1

looking further:

$ docker run --rm centos:6 cat /etc/redhat-release; echo $?
CentOS release 6.9 (Final)
0

$ docker run --rm centos:6 sh -c "cat /etc/redhat-release"; echo $?
139

uh?

$ docker run --rm centos:7 sh -c "cat /etc/redhat-release"; echo $?
CentOS Linux release 7.3.1611 (Core)
0

now trying old debian release:

$ docker run --rm -it debian:wheezy sh -c "cat /etc/debian_version"; echo $?
7.11
0

$ docker run --rm -it debian:wheezy bash -c "cat /etc/debian_version"; 
echo $?
139

hmmm

$ docker run --rm -it debian:jessie bash -c "cat /etc/debian_version"; 
echo $?
8.7
0

$ docker info
Server Version: 17.05.0-ce
Storage Driver: overlay2
  Backing Filesystem: extfs
Cgroup Driver: cgroupfs
Default Runtime: runc
Init Binary: docker-init
containerd version: 9048e5e50717ea4497b757314bad98ea3763c145
runc version: 9c2d8d184e5da67c95d601382adf14862e4f2228
init version: 949e6fa
Kernel Version: 4.11.0-1-amd64
Operating System: Debian GNU/Linux buster/sid
Architecture: x86_64

$ sudo journalctl -kb -l -o json-pretty
{
         "PRIORITY" : "6",
         "_TRANSPORT" : "kernel",
         "SYSLOG_FACILITY" : "0",
         "SYSLOG_IDENTIFIER" : "kernel",
         "MESSAGE" : "sh[23389] vsyscall attempted with vsyscall=none 
ip:ffffffffff600400 cs:33 sp:7ffcfd21a6c8 ax:ffffffffff600400 
si:7ffcfd21af6f di:0"
}
{
         "_TRANSPORT" : "kernel",
         "SYSLOG_FACILITY" : "0",
         "SYSLOG_IDENTIFIER" : "kernel",
         "MESSAGE" : "sh[23389]: segfault at ffffffffff600400 ip 
ffffffffff600400 sp 00007ffcfd21a6c8 error 15"
}

is it time to upgrade the docker image to centos:7 ?
