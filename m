Received: from eggs.gnu.org ([2001:4830:134:3::10]:41064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wjseven1707@gmail.com>) id 1fuSaY-0007Qi-Na
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 21:14:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wjseven1707@gmail.com>) id 1fuSO2-0004nC-6u
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 21:01:39 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132]:46710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wjseven1707@gmail.com>)
	id 1fuSO1-0004mC-Pm
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 21:01:38 -0400
Received: by mail-lf1-x132.google.com with SMTP id e23-v6so642311lfc.13
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 18:01:37 -0700 (PDT)
MIME-Version: 1.0
From: "John Y." <wjseven1707@gmail.com>
Date: Tue, 28 Aug 2018 09:01:24 +0800
Message-ID: <CAKAH_gkRfw1aPb8osySr+qj5vhiW_32coL95NgkQo4YE83zT6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Guest crash when VNC connection is established with
 password (QEMU 2.5.1.1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

(Sorry for repost,  I had asked in qemu-stable, but someone told me that I
should send to qemu-devel.)

After I updated my Centos to 7.5.1804, my virtual machine crashed when I
connected with vnc password.

*1. My problem=EF=BC=9A*

Here  what I tested:
(1).  started a guest with : qemu-system-x86_64 -m 2048 test.img -vnc
0.0.0.0:3 <http://0.0.0.0:7>,password -monitor stdio
(2). change password to 1234567.
(3). connected with VncViewer

Here was the output:

# qemu-system-x86_64 -m 2048 test.img -vnc 0.0.0.0:3,password -monitor stdi=
o
> QEMU 2.5.1.1 monitor - type 'help' for more information
> (qemu) change vnc password 12345678
> (qemu) Segmentation fault
>

I  debugged with gdb and got:

> (qemu) change vnc password 12345678
> (qemu)
> Program received signal SIGSEGV, Segmentation fault.
> 0x00007ffff528cc80 in pthread_mutex_lock () from /lib64/libpthread.so.0
> (gdb) bt
> #0  0x00007ffff528cc80 in pthread_mutex_lock () from /lib64/libpthread.so=
.0
> #1  0x0000555555a97f4a in qemu_mutex_lock (mutex=3D0x0) at
> util/qemu-thread-posix.c:73
> #2  0x0000555555a5cce3 in qcrypto_gcrypt_mutex_lock (priv=3D0x7ffff6e90ca=
0)
> at crypto/init.c:97
> #3  0x00007ffff6c217c5 in mutex_init () from /lib64/libgcrypt.so.11
> #4  0x00007ffff6c21baa in _gcry_ath_mutex_lock () from
> /lib64/libgcrypt.so.11
> #5  0x00007ffff6c5ad20 in lock_pool () from /lib64/libgcrypt.so.11
> #6  0x00007ffff6c5be2e in _gcry_rngcsprng_fast_poll () from
> /lib64/libgcrypt.so.11
> #7  0x00007ffff6c23d4d in _gcry_cipher_open () from /lib64/libgcrypt.so.1=
1
> #8  0x0000555555a60251 in qcrypto_cipher_new
> (alg=3DQCRYPTO_CIPHER_ALG_DES_RFB, mode=3DQCRYPTO_CIPHER_MODE_ECB,
> key=3D0x7fffffffdf30 "12345678\020", nkey=3D8, errp=3D0x7fffffffdf08) at
> ./crypto/cipher-gcrypt.c:97
> #9  0x00005555559d8912 in protocol_client_auth_vnc (vs=3D0x5555565b5660,
> data=3D0x555557a6c0a0 "\036\352\"s=D9=98\373\345<=DC=AF\210L\b;$\220\300\=
246WUU",
> len=3D16) at ui/vnc.c:2551
> #10 0x00005555559d60b5 in vnc_client_read (opaque=3D0x5555565b5660) at
> ui/vnc.c:1564
> #11 0x0000555555a046a7 in aio_dispatch (ctx=3D0x555556508790) at
> aio-posix.c:326
> #12 0x00005555559f4166 in aio_ctx_dispatch (source=3D0x555556508790,
> callback=3D0x0, user_data=3D0x0) at async.c:231
> #13 0x00007ffff5f10969 in g_main_context_dispatch () from
> /lib64/libglib-2.0.so.0
> #14 0x0000555555a026e7 in glib_pollfds_poll () at main-loop.c:211
> #15 0x0000555555a027c4 in os_host_main_loop_wait (timeout=3D54752182) at
> main-loop.c:256
> #16 0x0000555555a02874 in main_loop_wait (nonblocking=3D0) at main-loop.c=
:504
> #17 0x00005555558251c1 in main_loop () at vl.c:1923
> #18 0x000055555582cbe5 in main (argc=3D8, argv=3D0x7fffffffe558,
> envp=3D0x7fffffffe5a0) at vl.c:4699
>


*2.  Other Infomation*
(1).  Version of qemu:
QEMU emulator version 2.5.1.1, Copyright (c) 2003-2008 Fabrice Bellard

(2).  kernel and os=EF=BC=9A
kernel : 4.16.3-1.el7.elrepo.x86_64
os: CentOS Linux release 7.5.1804 (Core)

(3).  I had try /usr/libexec/qemu-kvm(qemu-kvm-1.5.3-156.el7_5.5)  and qemu
2.11, both of them worked fine.

(4).  Has no problem witout vnc password.

(5). I update my host with yum update.

(6).  Everything work find before update.

*3.  My Question*
For some reasons I have to use qemu 2.5.11 and update Centos.
(1) What causes this problem and how can I solve it ?

Looking forward to your reply.

Regards,
John
