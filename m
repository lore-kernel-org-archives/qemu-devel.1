Received: from eggs.gnu.org ([2001:4830:134:3::10]:40629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1etbS2-0005TG-0U
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:57:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1etbS0-000149-My
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:57:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54576 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1etbS0-00013w-Gj
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:57:56 -0500
From: marcandre.lureau@redhat.com
Date: Wed,  7 Mar 2018 16:57:41 +0100
Message-Id: <20180307155746.18526-4-marcandre.lureau@redhat.com>
In-Reply-To: <20180307155746.18526-1-marcandre.lureau@redhat.com>
References: <20180307155746.18526-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 3/8] MdeModulePkg: fix REGISITER -> REGISTER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: edk2-devel@lists.01.org
Cc: pjones@redhat.com, jiewen.yao@intel.com, stefanb@linux.vnet.ibm.com, lersek@redhat.com, qemu-devel@nongnu.org, javierm@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Cc: Laszlo Ersek <lersek@redhat.com>
Contributed-under: TianoCore Contribution Agreement 1.0
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 MdeModulePkg/Core/Pei/Dispatcher/Dispatcher.c | 18 +++++++++---------
 MdeModulePkg/Core/Pei/Image/Image.c           |  4 ++--
 MdeModulePkg/Core/Pei/PeiMain.h               |  2 +-
 MdeModulePkg/Core/Pei/PeiMain/PeiMain.c       |  2 +-
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/MdeModulePkg/Core/Pei/Dispatcher/Dispatcher.c b/MdeModulePkg=
/Core/Pei/Dispatcher/Dispatcher.c
index 79f2e5cebcbe..027176d872c7 100644
--- a/MdeModulePkg/Core/Pei/Dispatcher/Dispatcher.c
+++ b/MdeModulePkg/Core/Pei/Dispatcher/Dispatcher.c
@@ -970,7 +970,7 @@ PeiDispatcher (
   if ((Private->PeiMemoryInstalled) && (Private->HobList.HandoffInformat=
ionTable->BootMode !=3D BOOT_ON_S3_RESUME || PcdGetBool (PcdShadowPeimOnS=
3Boot))) {
     //
     // Once real memory is available, shadow the RegisterForShadow modul=
es. And meanwhile
-    // update the modules' status from PEIM_STATE_REGISITER_FOR_SHADOW t=
o PEIM_STATE_DONE.
+    // update the modules' status from PEIM_STATE_REGISTER_FOR_SHADOW to=
 PEIM_STATE_DONE.
     //
     SaveCurrentPeimCount  =3D Private->CurrentPeimCount;
     SaveCurrentFvCount    =3D Private->CurrentPeimFvCount;
@@ -978,7 +978,7 @@ PeiDispatcher (
=20
     for (Index1 =3D 0; Index1 <=3D SaveCurrentFvCount; Index1++) {
       for (Index2 =3D 0; (Index2 < PcdGet32 (PcdPeiCoreMaxPeimPerFv)) &&=
 (Private->Fv[Index1].FvFileHandles[Index2] !=3D NULL); Index2++) {
-        if (Private->Fv[Index1].PeimState[Index2] =3D=3D PEIM_STATE_REGI=
SITER_FOR_SHADOW) {
+        if (Private->Fv[Index1].PeimState[Index2] =3D=3D PEIM_STATE_REGI=
STER_FOR_SHADOW) {
           PeimFileHandle =3D Private->Fv[Index1].FvFileHandles[Index2];
           Private->CurrentFileHandle   =3D PeimFileHandle;
           Private->CurrentPeimFvCount  =3D Index1;
@@ -986,13 +986,13 @@ PeiDispatcher (
           Status =3D PeiLoadImage (
                     (CONST EFI_PEI_SERVICES **) &Private->Ps,
                     PeimFileHandle,
-                    PEIM_STATE_REGISITER_FOR_SHADOW,
+                    PEIM_STATE_REGISTER_FOR_SHADOW,
                     &EntryPoint,
                     &AuthenticationState
                     );
           if (Status =3D=3D EFI_SUCCESS) {
             //
-            // PEIM_STATE_REGISITER_FOR_SHADOW move to PEIM_STATE_DONE
+            // PEIM_STATE_REGISTER_FOR_SHADOW move to PEIM_STATE_DONE
             //
             Private->Fv[Index1].PeimState[Index2]++;
             //
@@ -1165,7 +1165,7 @@ PeiDispatcher (
             //
             PeiCheckAndSwitchStack (SecCoreData, Private);
=20
-            if ((Private->PeiMemoryInstalled) && (Private->Fv[FvCount].P=
eimState[PeimCount] =3D=3D PEIM_STATE_REGISITER_FOR_SHADOW) &&   \
+            if ((Private->PeiMemoryInstalled) && (Private->Fv[FvCount].P=
eimState[PeimCount] =3D=3D PEIM_STATE_REGISTER_FOR_SHADOW) &&   \
                 (Private->HobList.HandoffInformationTable->BootMode !=3D=
 BOOT_ON_S3_RESUME || PcdGetBool (PcdShadowPeimOnS3Boot))) {
               //
               // If memory is available we shadow images by default for =
performance reasons.
@@ -1179,7 +1179,7 @@ PeiDispatcher (
                 Status =3D PeiLoadImage (
                            PeiServices,
                            PeimFileHandle,
-                           PEIM_STATE_REGISITER_FOR_SHADOW,
+                           PEIM_STATE_REGISTER_FOR_SHADOW,
                            &EntryPoint,
                            &AuthenticationState
                            );
@@ -1192,7 +1192,7 @@ PeiDispatcher (
               //PERF_END (PeiServices, L"PEIM", PeimFileHandle, 0);
=20
               //
-              // PEIM_STATE_REGISITER_FOR_SHADOW move to PEIM_STATE_DONE
+              // PEIM_STATE_REGISTER_FOR_SHADOW move to PEIM_STATE_DONE
               //
               Private->Fv[FvCount].PeimState[PeimCount]++;
=20
@@ -1356,14 +1356,14 @@ PeiRegisterForShadow (
     return EFI_NOT_FOUND;
   }
=20
-  if (Private->Fv[Private->CurrentPeimFvCount].PeimState[Private->Curren=
tPeimCount] >=3D PEIM_STATE_REGISITER_FOR_SHADOW) {
+  if (Private->Fv[Private->CurrentPeimFvCount].PeimState[Private->Curren=
tPeimCount] >=3D PEIM_STATE_REGISTER_FOR_SHADOW) {
     //
     // If the PEIM has already entered the PEIM_STATE_REGISTER_FOR_SHADO=
W or PEIM_STATE_DONE then it's already been started
     //
     return EFI_ALREADY_STARTED;
   }
=20
-  Private->Fv[Private->CurrentPeimFvCount].PeimState[Private->CurrentPei=
mCount] =3D PEIM_STATE_REGISITER_FOR_SHADOW;
+  Private->Fv[Private->CurrentPeimFvCount].PeimState[Private->CurrentPei=
mCount] =3D PEIM_STATE_REGISTER_FOR_SHADOW;
=20
   return EFI_SUCCESS;
 }
diff --git a/MdeModulePkg/Core/Pei/Image/Image.c b/MdeModulePkg/Core/Pei/=
Image/Image.c
index f41d3acac77e..f07f48823117 100644
--- a/MdeModulePkg/Core/Pei/Image/Image.c
+++ b/MdeModulePkg/Core/Pei/Image/Image.c
@@ -387,7 +387,7 @@ LoadAndRelocatePeCoffImage (
   }
   IsRegisterForShadow =3D FALSE;
   if ((Private->CurrentFileHandle =3D=3D FileHandle)=20
-    && (Private->Fv[Private->CurrentPeimFvCount].PeimState[Private->Curr=
entPeimCount] =3D=3D PEIM_STATE_REGISITER_FOR_SHADOW)) {
+    && (Private->Fv[Private->CurrentPeimFvCount].PeimState[Private->Curr=
entPeimCount] =3D=3D PEIM_STATE_REGISTER_FOR_SHADOW)) {
     IsRegisterForShadow =3D TRUE;
   }
=20
@@ -876,7 +876,7 @@ PeiLoadImage (
         //
         // The shadowed PEIM must be relocatable.
         //
-        if (PeimState =3D=3D PEIM_STATE_REGISITER_FOR_SHADOW) {
+        if (PeimState =3D=3D PEIM_STATE_REGISTER_FOR_SHADOW) {
           IsStrip =3D RelocationIsStrip ((VOID *) (UINTN) ImageAddress);
           ASSERT (!IsStrip);
           if (IsStrip) {
diff --git a/MdeModulePkg/Core/Pei/PeiMain.h b/MdeModulePkg/Core/Pei/PeiM=
ain.h
index fef3753e4b3b..a1cdbc15d98a 100644
--- a/MdeModulePkg/Core/Pei/PeiMain.h
+++ b/MdeModulePkg/Core/Pei/PeiMain.h
@@ -104,7 +104,7 @@ typedef struct {
 //
 #define PEIM_STATE_NOT_DISPATCHED         0x00
 #define PEIM_STATE_DISPATCHED             0x01
-#define PEIM_STATE_REGISITER_FOR_SHADOW   0x02
+#define PEIM_STATE_REGISTER_FOR_SHADOW    0x02
 #define PEIM_STATE_DONE                   0x03
=20
 typedef struct {
diff --git a/MdeModulePkg/Core/Pei/PeiMain/PeiMain.c b/MdeModulePkg/Core/=
Pei/PeiMain/PeiMain.c
index 3cd61906c3df..775bf18ce938 100644
--- a/MdeModulePkg/Core/Pei/PeiMain/PeiMain.c
+++ b/MdeModulePkg/Core/Pei/PeiMain/PeiMain.c
@@ -104,7 +104,7 @@ ShadowPeiCore (
   Status =3D PeiLoadImage (
               GetPeiServicesTablePointer (),
               *((EFI_PEI_FILE_HANDLE*)&PeiCoreFileHandle),
-              PEIM_STATE_REGISITER_FOR_SHADOW,
+              PEIM_STATE_REGISTER_FOR_SHADOW,
               &EntryPoint,
               &AuthenticationState
               );
--=20
2.16.2.346.g9779355e34
