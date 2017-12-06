Received: from eggs.gnu.org ([2001:4830:134:3::10]:50334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eMhzO-0001t5-J4
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 17:16:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eMhzN-0004wW-DH
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 17:16:26 -0500
References: <1512457825-3847-1-git-send-email-thuth@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <ee0ee3e4-f8d4-048f-b772-49d15ada4254@redhat.com>
Date: Wed, 6 Dec 2017 17:16:17 -0500
MIME-Version: 1.0
In-Reply-To: <1512457825-3847-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/ide: Remove duplicated definitions
 from ahci_internal.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, qemu-block@nongnu.org

I tweaked this again, sorry:

The names need to stay public, but the wrappers to manipulate the
objects can stay internal. Minor difference.

If that's okay, I'll just merge this in.
OK?

--js

diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci_internal.h
index ce2e818c8c..8c755d4ca1 100644
--- a/hw/ide/ahci_internal.h
+++ b/hw/ide/ahci_internal.h
@@ -311,8 +311,6 @@ struct AHCIPCIState {
     AHCIState ahci;
 };

-#define TYPE_ICH9_AHCI "ich9-ahci"
-
 #define ICH_AHCI(obj) \
     OBJECT_CHECK(AHCIPCIState, (obj), TYPE_ICH9_AHCI)

@@ -375,10 +373,8 @@ void ahci_uninit(AHCIState *s);

 void ahci_reset(AHCIState *s);

-#define TYPE_SYSBUS_AHCI "sysbus-ahci"
 #define SYSBUS_AHCI(obj) OBJECT_CHECK(SysbusAHCIState, (obj),
TYPE_SYSBUS_AHCI)

-#define TYPE_ALLWINNER_AHCI "allwinner-ahci"
 #define ALLWINNER_AHCI(obj) OBJECT_CHECK(AllwinnerAHCIState, (obj), \
                        TYPE_ALLWINNER_AHCI)

diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
index 5a06537e6b..b7bb2b02d6 100644
--- a/include/hw/ide/ahci.h
+++ b/include/hw/ide/ahci.h
@@ -54,14 +54,10 @@ typedef struct AHCIPCIState AHCIPCIState;

 #define TYPE_ICH9_AHCI "ich9-ahci"

-#define ICH_AHCI(obj) \
-    OBJECT_CHECK(AHCIPCIState, (obj), TYPE_ICH9_AHCI)
-
 int32_t ahci_get_num_ports(PCIDevice *dev);
 void ahci_ide_create_devs(PCIDevice *dev, DriveInfo **hd);

 #define TYPE_SYSBUS_AHCI "sysbus-ahci"
-#define SYSBUS_AHCI(obj) OBJECT_CHECK(SysbusAHCIState, (obj),
TYPE_SYSBUS_AHCI)

 typedef struct SysbusAHCIState {
     /*< private >*/
@@ -73,8 +69,6 @@ typedef struct SysbusAHCIState {
 } SysbusAHCIState;

 #define TYPE_ALLWINNER_AHCI "allwinner-ahci"
-#define ALLWINNER_AHCI(obj) OBJECT_CHECK(AllwinnerAHCIState, (obj), \
-                       TYPE_ALLWINNER_AHCI)

 #define ALLWINNER_AHCI_MMIO_OFF  0x80
 #define ALLWINNER_AHCI_MMIO_SIZE 0x80


On 12/05/2017 02:10 AM, Thomas Huth wrote:
> The same definitions can also be found in include/hw/ide/ahci.h
> so let's remove these #defines from ahci_internal.h.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Also remove TYPE_ICH9_AHCI as suggested by John
> 
>  hw/ide/ahci_internal.h | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci_internal.h
> index ce2e818..e3e3ed2 100644
> --- a/hw/ide/ahci_internal.h
> +++ b/hw/ide/ahci_internal.h
> @@ -311,11 +311,6 @@ struct AHCIPCIState {
>      AHCIState ahci;
>  };
>  
> -#define TYPE_ICH9_AHCI "ich9-ahci"
> -
> -#define ICH_AHCI(obj) \
> -    OBJECT_CHECK(AHCIPCIState, (obj), TYPE_ICH9_AHCI)
> -
>  extern const VMStateDescription vmstate_ahci;
>  
>  #define VMSTATE_AHCI(_field, _state) {                               \
> @@ -375,11 +370,4 @@ void ahci_uninit(AHCIState *s);
>  
>  void ahci_reset(AHCIState *s);
>  
> -#define TYPE_SYSBUS_AHCI "sysbus-ahci"
> -#define SYSBUS_AHCI(obj) OBJECT_CHECK(SysbusAHCIState, (obj), TYPE_SYSBUS_AHCI)
> -
> -#define TYPE_ALLWINNER_AHCI "allwinner-ahci"
> -#define ALLWINNER_AHCI(obj) OBJECT_CHECK(AllwinnerAHCIState, (obj), \
> -                       TYPE_ALLWINNER_AHCI)
> -
>  #endif /* HW_IDE_AHCI_H */
> 
