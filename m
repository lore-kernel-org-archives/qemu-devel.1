Received: from eggs.gnu.org ([209.51.188.92]:45220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJ46K-0005gR-CP
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:41:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJ46I-0003Nc-Pq
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:41:20 -0400
Received: from indium.canonical.com ([91.189.90.7]:47344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJ46I-0003HR-Fs
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:41:18 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJ46E-00050C-P1
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 22:41:15 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 65EEF2E8196
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 22:41:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Apr 2019 22:31:37 -0000
From: Erik Kline <1814352@bugs.launchpad.net>
Reply-To: Bug 1814352 <1814352@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154907151753.31178.12938166708527410326.malonedeb@gac.canonical.com>
Message-Id: <155605869747.6483.11709055267790106875.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1814352] Re: SIOCGIFNAME takes a struct ifreq not
 an integer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Patch sent to the list.  Apologies for the delay.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1814352

Title:
  SIOCGIFNAME takes a struct ifreq not an integer

Status in QEMU:
  Confirmed

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
