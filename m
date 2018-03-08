Received: from eggs.gnu.org ([2001:4830:134:3::10]:57548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1etut0-0002pF-91
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 07:43:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1etusv-0000kk-De
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 07:43:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60120
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1etusv-0000kK-84
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 07:43:01 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w28CdUmw084080
	for <qemu-devel@nongnu.org>; Thu, 8 Mar 2018 07:43:00 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gk3btddys-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 07:43:00 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 8 Mar 2018 12:42:58 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 8 Mar 2018 13:42:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <7c67e799-f4d8-6bf5-004e-6e1106fe053a@de.ibm.com>
Subject: [Qemu-devel] qemu crashes with vnc and multiple outputs + console
 redirection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>

Gerd,

I am playing with the virtio-gpu support on s390 and for that I also wanted to multiplex
the existing consoles. So I basically used the max_outputs=2 of virtio gpu to be able
to switch with ctrl+alt+1 and 3 between the virtio gpu and the sclplm console.

-chardev pty,id=charconsole0 -device sclpconsole,chardev=charconsole0,id=console0
-chardev vc,id=charconsole1 -device sclplmconsole,chardev=charconsole1,id=console1
-device virtio-keyboard-ccw,id=input0,devno=fe.0.0001
-vnc 0.0.0.0:0
-k en-us
-device virtio-gpu-ccw,id=video0,max_outputs=2,devno=fe.0.0008 


This seems to work fine, vrtio-gpu is on 1 and sclplm is on 3. Problem is, 
when I randomly do ctrl+alt+[^1..9] sooner or later qemu crashes with

(gdb) bt
#0  0x000000000123dd9e in surface_width (s=0x0) at /home/cborntra/REPOS/qemu/include/ui/console.h:339
#1  0x000000000123dd9e in vnc_width (vd=vd@entry=0x345e9100) at /home/cborntra/REPOS/qemu/ui/vnc.c:610
#2  0x000000000123df84 in vnc_update_server_surface (vd=vd@entry=0x345e9100) at /home/cborntra/REPOS/qemu/ui/vnc.c:735
#3  0x00000000012437dc in vnc_dpy_switch (dcl=0x345e9140, surface=0x0) at /home/cborntra/REPOS/qemu/ui/vnc.c:756
#4  0x0000000001233456 in console_select (index=index@entry=1) at /home/cborntra/REPOS/qemu/ui/console.c:1039
#5  0x00000000012400ba in do_key_event (vs=vs@entry=0x34652130, down=down@entry=1, keycode=keycode@entry=3, sym=sym@entry=50) at /home/cborntra/REPOS/qemu/ui/vnc.c:1801
#6  0x00000000012406e2 in key_event (vs=vs@entry=0x34652130, down=down@entry=1, sym=<optimized out>) at /home/cborntra/REPOS/qemu/ui/vnc.c:2010
#7  0x0000000001243bea in protocol_client_msg (vs=0x34652130, data=0x346485e0 "\004\001", len=<optimized out>) at /home/cborntra/REPOS/qemu/ui/vnc.c:2341
#8  0x0000000001241bae in vnc_client_read (vs=vs@entry=0x34652130) at /home/cborntra/REPOS/qemu/ui/vnc.c:1511
#9  0x0000000001241c32 in vnc_client_io (ioc=<error reading variable: value has been optimized out>, condition=<error reading variable: value has been optimized out>, opaque=0x34652130, opaque@entry=<error reading variable: value has been optimized out>) at /home/cborntra/REPOS/qemu/ui/vnc.c:1531
#10 0x00000000013015fe in qio_channel_fd_source_dispatch (source=<optimized out>, callback=<optimized out>, user_data=<optimized out>)
    at /home/cborntra/REPOS/qemu/io/channel-watch.c:84
#11 0x000003ff968510aa in g_main_context_dispatch () at /lib64/libglib-2.0.so.0
#12 0x00000000013522e6 in glib_pollfds_poll () at /home/cborntra/REPOS/qemu/util/main-loop.c:214
#13 0x00000000013523ba in os_host_main_loop_wait (timeout=<optimized out>) at /home/cborntra/REPOS/qemu/util/main-loop.c:261
#14 0x0000000001352500 in main_loop_wait (nonblocking=nonblocking@entry=0) at /home/cborntra/REPOS/qemu/util/main-loop.c:515
#15 0x0000000001164a06 in main_loop () at /home/cborntra/REPOS/qemu/vl.c:1940
#16 0x00000000011684d8 in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at /home/cborntra/REPOS/qemu/vl.c:4764


any quick idea?

Christian
