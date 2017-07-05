Received: from eggs.gnu.org ([2001:4830:134:3::10]:57018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dSf8k-0004Xi-R3
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:54:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dSf8k-0006ve-0s
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:54:26 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34780)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1dSf8j-0006vP-Qa
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:54:25 -0400
Received: by mail-wm0-x244.google.com with SMTP id p204so30729591wmg.1
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 00:54:25 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Wed,  5 Jul 2017 10:54:10 +0300
Message-Id: <20170705075411.6556-5-sameeh@daynix.com>
In-Reply-To: <20170705075411.6556-1-sameeh@daynix.com>
References: <20170705075411.6556-1-sameeh@daynix.com>
Subject: [Qemu-devel] [PATCH 4/5] qga-win: Add qga-serial-listener to msi
 installer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Yan Vugenfirer <yan@daynix.com>

From: Sameeh Jubran <sjubran@redhat.com>

Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
---
 qga/installer/qemu-ga.wxs | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/qga/installer/qemu-ga.wxs b/qga/installer/qemu-ga.wxs
index fa2260c..40b7a7b 100644
--- a/qga/installer/qemu-ga.wxs
+++ b/qga/installer/qemu-ga.wxs
@@ -83,6 +83,9 @@
             </ServiceInstall>
             <ServiceControl Id="StartService" Start="install" Stop="both" Remove="uninstall" Name="QEMU-GA" Wait="no" />
           </Component>
+          <Component Id="qga_serial_listener" Guid="{1B7B5172-4097-46E1-8A76-CCF2D31AE450}">
+            <File Id="qga_serial_listener.exe" Name="qga-serial-listener.exe" Source="$(env.BUILD_DIR)/qga-serial-listener.exe" KeyPath="yes" DiskId="1"/>
+          </Component>
           <?ifdef var.InstallVss?>
           <Component Id="qga_vss_dll" Guid="{CB19C453-FABB-4BB1-ABAB-6B74F687BFBB}">
             <File Id="qga_vss.dll" Name="qga-vss.dll" Source="$(env.BUILD_DIR)/qga/vss-win32/qga-vss.dll" KeyPath="yes" DiskId="1"/>
@@ -139,6 +142,24 @@
     <Property Id="cmd" Value="cmd.exe"/>
     <Property Id="REINSTALLMODE" Value="amus"/>
 
+
+    <CustomAction Id="RegisterSerialListener"
+	      ExeCommand='/c "[qemu_ga_directory]qemu-ga.exe" -s sl-install'
+              Execute="deferred"
+              Property="cmd"
+              Impersonate="no"
+              Return="check"
+              >
+    </CustomAction>
+    <CustomAction Id="UnRegisterSerialListener"
+	      ExeCommand='/c "[qemu_ga_directory]qemu-ga.exe" -s sl-uninstall'
+              Execute="deferred"
+              Property="cmd"
+              Impersonate="no"
+              Return="check"
+              >
+    </CustomAction>
+
     <?ifdef var.InstallVss?>
     <CustomAction Id="RegisterCom"
               ExeCommand='/c "[qemu_ga_directory]qemu-ga.exe" -s vss-install'
@@ -160,6 +181,7 @@
 
     <Feature Id="QEMUFeature" Title="QEMU Guest Agent" Level="1">
       <ComponentRef Id="qemu_ga" />
+      <ComponentRef Id="qga_serial_listener" />
       <?ifdef var.InstallVss?>
       <ComponentRef Id="qga_vss_dll" />
       <ComponentRef Id="qga_vss_tlb" />
@@ -176,6 +198,8 @@
     </Feature>
 
     <InstallExecuteSequence>
+      <Custom Action="UnRegisterSerialListener" After="StopServices">Installed</Custom>
+      <Custom Action="RegisterSerialListener" Before="InstallFinalize">NOT REMOVE</Custom>
       <?ifdef var.InstallVss?>
       <Custom Action="UnRegisterCom" After="StopServices">Installed</Custom>
       <Custom Action="RegisterCom" After="InstallServices">NOT REMOVE</Custom>
-- 
2.9.4
