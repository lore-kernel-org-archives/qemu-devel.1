Received: from eggs.gnu.org ([209.51.188.92]:44819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gpkNX-0006AS-Ie
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 20:45:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gpkNW-0003Sx-GX
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 20:45:55 -0500
Received: from indium.canonical.com ([91.189.90.7]:52708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gpkNW-0003Jv-6M
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 20:45:54 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gpkNB-0000nS-OP
	for <qemu-devel@nongnu.org>; Sat, 02 Feb 2019 01:45:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AB1402E8037
	for <qemu-devel@nongnu.org>; Sat,  2 Feb 2019 01:45:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 02 Feb 2019 01:38:37 -0000
From: Erik Kline <1814352@bugs.launchpad.net>
Reply-To: Bug 1814352 <1814352@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154907151753.31178.12938166708527410326.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1814352] [NEW] SIOCGIFNAME takes a struct ifreq
 not an integer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

The ioctl SIOCGIFNAME takes a pointer to a struct ifreq, not an integer.
This leads to if_indextoname() not correctly returning interface names
(well, not if they're longer than 4 characters including the trailing
NULL ;-).

This is observed on v3.1.0.

The following one-line patch will be sent to the qemu-devel mailing
list:

"""
diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index ae8951625f..37501f575c 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -178,7 +178,7 @@
 #endif /* CONFIG_USBFS */
 =

   IOCTL(SIOCATMARK, IOC_R, MK_PTR(TYPE_INT))
-  IOCTL(SIOCGIFNAME, IOC_RW, MK_PTR(TYPE_INT))
+  IOCTL(SIOCGIFNAME, IOC_RW, MK_PTR(MK_STRUCT(STRUCT_int_ifreq)))
   IOCTL(SIOCGIFFLAGS, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
   IOCTL(SIOCSIFFLAGS, IOC_W, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
   IOCTL(SIOCGIFADDR, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_sockaddr_ifreq=
)))
"""

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1814352

Title:
  SIOCGIFNAME takes a struct ifreq not an integer

Status in QEMU:
  New

Bug description:
  The ioctl SIOCGIFNAME takes a pointer to a struct ifreq, not an
  integer.  This leads to if_indextoname() not correctly returning
  interface names (well, not if they're longer than 4 characters
  including the trailing NULL ;-).

  This is observed on v3.1.0.

  The following one-line patch will be sent to the qemu-devel mailing
  list:

  """
  diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
  index ae8951625f..37501f575c 100644
  --- a/linux-user/ioctls.h
  +++ b/linux-user/ioctls.h
  @@ -178,7 +178,7 @@
   #endif /* CONFIG_USBFS */
   =

     IOCTL(SIOCATMARK, IOC_R, MK_PTR(TYPE_INT))
  -  IOCTL(SIOCGIFNAME, IOC_RW, MK_PTR(TYPE_INT))
  +  IOCTL(SIOCGIFNAME, IOC_RW, MK_PTR(MK_STRUCT(STRUCT_int_ifreq)))
     IOCTL(SIOCGIFFLAGS, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_short_ifreq=
)))
     IOCTL(SIOCSIFFLAGS, IOC_W, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
     IOCTL(SIOCGIFADDR, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_sockaddr_ifr=
eq)))
  """

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1814352/+subscriptions
