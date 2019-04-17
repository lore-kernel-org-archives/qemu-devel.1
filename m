Received: from eggs.gnu.org ([209.51.188.92]:40978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGmuT-0001sx-T2
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:55:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGmuO-0003Gb-Lk
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:55:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:42228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hGmuO-0003FG-93
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:55:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hGmuN-0004Yu-1y
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 15:55:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EABC12E80C8
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 15:55:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Apr 2019 15:44:12 -0000
From: Mark Eichin <eichin@gmail.com>
Reply-To: Bug 1825207 <1825207@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <155551585261.7051.17290095032881696320.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1825207] [NEW] fw_cfg_machine_reset destroys user
 bootorder setting
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

Demonstrated against 2.11 (ubuntu bionic 1:2.11+dfsg-1ubuntu7.12) and
3.1 (as built under bionic from the 1:3.1+dfsg-2ubuntu3 source package)
although the code hasn't changed between them and github master also
appears to have this same code branch.

What I was trying to do: select a boot disk using `-fw_cfg
name=3Dbootorder,string=3D/pci@i0cf8/*@6` based on the qemu and seabios
documentation.  (Why do I want to do that? using qemu for installer
testing for a specific kind of real machine and need to match the bios
boot order.)

What happened instead: same search-based boot order that I get without
that option.  Also, /sys/firmware/qemu_fw_cfg/by_name/bootorder/raw is
empty and .../size is "0".

Brutal work around that did a useful thing:

--- qemu-3.1+dfsg.orig/hw/nvram/fw_cfg.c
+++ qemu-3.1+dfsg/hw/nvram/fw_cfg.c
@@ -869,8 +869,10 @@ static void fw_cfg_machine_reset(void *o
     FWCfgState *s =3D opaque;
     char *bootindex =3D get_boot_devices_list(&len);
 =

+#if 0
     ptr =3D fw_cfg_modify_file(s, "bootorder", (uint8_t *)bootindex, len);
     g_free(ptr);
+#endif
 }

This change allowed the boot to work (so my bootorder setting was making
it to seabios) and also showed up explicitly in
/sys/firmware/qemu_fw_cfg.

I don't know if fw_cfg_modify_file is intended to append rather than
replace, but it doesn't; based on the seabios "Runtime_config" docs
which suggest "look at the Searching bootorder for output and paste that
into the bootorder file" I'd instead just have it only fill in bootorder
if there's *no* existing setting, since a user can read out the defaults
and copy them in as described if they want the fallback, but that's just
from my interpretation of the docs.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1825207

Title:
  fw_cfg_machine_reset destroys user bootorder setting

Status in QEMU:
  New

Bug description:
  Demonstrated against 2.11 (ubuntu bionic 1:2.11+dfsg-1ubuntu7.12) and
  3.1 (as built under bionic from the 1:3.1+dfsg-2ubuntu3 source
  package) although the code hasn't changed between them and github
  master also appears to have this same code branch.

  What I was trying to do: select a boot disk using `-fw_cfg
  name=3Dbootorder,string=3D/pci@i0cf8/*@6` based on the qemu and seabios
  documentation.  (Why do I want to do that? using qemu for installer
  testing for a specific kind of real machine and need to match the bios
  boot order.)

  What happened instead: same search-based boot order that I get without
  that option.  Also, /sys/firmware/qemu_fw_cfg/by_name/bootorder/raw is
  empty and .../size is "0".

  Brutal work around that did a useful thing:

  --- qemu-3.1+dfsg.orig/hw/nvram/fw_cfg.c
  +++ qemu-3.1+dfsg/hw/nvram/fw_cfg.c
  @@ -869,8 +869,10 @@ static void fw_cfg_machine_reset(void *o
       FWCfgState *s =3D opaque;
       char *bootindex =3D get_boot_devices_list(&len);
   =

  +#if 0
       ptr =3D fw_cfg_modify_file(s, "bootorder", (uint8_t *)bootindex, len=
);
       g_free(ptr);
  +#endif
   }

  This change allowed the boot to work (so my bootorder setting was
  making it to seabios) and also showed up explicitly in
  /sys/firmware/qemu_fw_cfg.

  I don't know if fw_cfg_modify_file is intended to append rather than
  replace, but it doesn't; based on the seabios "Runtime_config" docs
  which suggest "look at the Searching bootorder for output and paste
  that into the bootorder file" I'd instead just have it only fill in
  bootorder if there's *no* existing setting, since a user can read out
  the defaults and copy them in as described if they want the fallback,
  but that's just from my interpretation of the docs.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1825207/+subscriptions
