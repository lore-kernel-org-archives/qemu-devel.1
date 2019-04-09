Received: from eggs.gnu.org ([209.51.188.92]:56971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hDvRi-0007oK-7m
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 14:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hDvRg-0001jd-Ri
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 14:26:10 -0400
Received: from indium.canonical.com ([91.189.90.7]:45416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hDvRg-0001jB-Kc
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 14:26:08 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hDvRf-0006EH-C6
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 18:26:07 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 574932E8070
	for <qemu-devel@nongnu.org>; Tue,  9 Apr 2019 18:26:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Apr 2019 18:18:49 -0000
From: Erik Kline <1814352@bugs.launchpad.net>
Reply-To: Bug 1814352 <1814352@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154907151753.31178.12938166708527410326.malonedeb@gac.canonical.com>
	<155481790266.8592.9119116041656314996.malone@wampee.canonical.com>
Message-Id: <CAAedzxqBuP98u=YkrK7NU7p7eECODcxHcvspTc09c0+FHFxNnA@mail.gmail.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1814352] Re: SIOCGIFNAME takes a struct ifreq
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

Sure.  Looking at HEAD, and even the surrounding the lines, I think I
should have tried STRUCT_short_ifreq instead of STRUCT_int_ifreq, though
I'm not sure what the real difference would be.

I'll try to test internally with the _short_ version and if that works send
that.

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
