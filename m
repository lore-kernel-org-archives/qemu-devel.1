Received: from eggs.gnu.org ([2001:4830:134:3::10]:42066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZH-0007wY-ND
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZF-0005yL-D3
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:15 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:37007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxZF-0005x4-1e
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:13 -0500
Received: by mail-wr0-x244.google.com with SMTP id f8so5037836wre.4
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:32:12 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:31:09 +0100
Message-Id: <1515756676-3860-46-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 45/52] maint: Fix macros with broken
 'do/while(0); ' usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

The point of writing a macro embedded in a 'do { ... } while (0)'
loop (particularly if the macro has multiple statements or would
otherwise end with an 'if' statement) is so that the macro can be
used as a drop-in statement with the caller supplying the
trailing ';'.  Although our coding style frowns on brace-less 'if':
  if (cond)
    statement;
  else
    something else;
that is the classic case where failure to use do/while(0) wrapping
would cause the 'else' to pair with any embedded 'if' in the macro
rather than the intended outer 'if'.  But conversely, if the macro
includes an embedded ';', then the same brace-less coding style
would now have two statements, making the 'else' a syntax error
rather than pairing with the outer 'if'.  Thus, even though our
coding style with required braces is not impacted, ending a macro
with ';' makes our code harder to port to projects that use
brace-less styles.

The change should have no semantic impact.  I was not able to
fully compile-test all of the changes (as some of them are
examples of the ugly bit-rotting debug print statements that are
completely elided by default, and I didn't want to recompile
with the necessary -D witnesses - cleaning those up is left as a
bite-sized task for another day); I did, however, audit that for
all files touched, all callers of the changed macros DID supply
a trailing ';' at the callsite, and did not appear to be used
as part of a brace-less conditional.

Found mechanically via: $ git grep -B1 'while (0);' | grep -A1 \\\\

Signed-off-by: Eric Blake <eblake@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20171201232433.25193-7-eblake@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/paaudio.c            | 4 ++--
 hw/adc/stm32f2xx_adc.c     | 2 +-
 hw/block/m25p80.c          | 2 +-
 hw/char/cadence_uart.c     | 2 +-
 hw/char/stm32f2xx_usart.c  | 2 +-
 hw/display/cg3.c           | 2 +-
 hw/display/dpcd.c          | 2 +-
 hw/display/xlnx_dp.c       | 2 +-
 hw/dma/pl330.c             | 2 +-
 hw/dma/xlnx-zynq-devcfg.c  | 2 +-
 hw/dma/xlnx_dpdma.c        | 2 +-
 hw/i2c/i2c-ddc.c           | 2 +-
 hw/misc/auxbus.c           | 2 +-
 hw/misc/macio/mac_dbdma.c  | 4 ++--
 hw/misc/mmio_interface.c   | 2 +-
 hw/misc/stm32f2xx_syscfg.c | 2 +-
 hw/misc/zynq_slcr.c        | 2 +-
 hw/net/cadence_gem.c       | 2 +-
 hw/ssi/mss-spi.c           | 2 +-
 hw/ssi/stm32f2xx_spi.c     | 2 +-
 hw/ssi/xilinx_spi.c        | 2 +-
 hw/ssi/xilinx_spips.c      | 2 +-
 hw/timer/a9gtimer.c        | 2 +-
 hw/timer/cadence_ttc.c     | 2 +-
 hw/timer/mss-timer.c       | 2 +-
 hw/timer/stm32f2xx_timer.c | 2 +-
 hw/tpm/tpm_passthrough.c   | 2 +-
 hw/tpm/tpm_tis.c           | 2 +-
 migration/rdma.c           | 2 +-
 target/arm/translate-a64.c | 2 +-
 target/s390x/kvm.c         | 2 +-
 tests/acpi-utils.h         | 8 ++++----
 tests/tcg/test-mmap.c      | 2 +-
 ui/sdl_zoom_template.h     | 8 ++++----
 34 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index 65beb6f..2a35e6f 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -89,7 +89,7 @@ static inline int PA_STREAM_IS_GOOD(pa_stream_state_t x)
             }                                                   \
             goto label;                                         \
         }                                                       \
-    } while (0);
+    } while (0)
 
 #define CHECK_DEAD_GOTO(c, stream, rerror, label)                       \
     do {                                                                \
@@ -107,7 +107,7 @@ static inline int PA_STREAM_IS_GOOD(pa_stream_state_t x)
             }                                                           \
             goto label;                                                 \
         }                                                               \
-    } while (0);
+    } while (0)
 
 static int qpa_simple_read (PAVoiceIn *p, void *data, size_t length, int *rerror)
 {
diff --git a/hw/adc/stm32f2xx_adc.c b/hw/adc/stm32f2xx_adc.c
index 90fe9de..13f31ad 100644
--- a/hw/adc/stm32f2xx_adc.c
+++ b/hw/adc/stm32f2xx_adc.c
@@ -37,7 +37,7 @@
     if (STM_ADC_ERR_DEBUG >= lvl) { \
         qemu_log("%s: " fmt, __func__, ## args); \
     } \
-} while (0);
+} while (0)
 
 #define DB_PRINT(fmt, args...) DB_PRINT_L(1, fmt, ## args)
 
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index ea14216..b49c8e9 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -40,7 +40,7 @@
         fprintf(stderr,  ": %s: ", __func__); \
         fprintf(stderr, ## __VA_ARGS__); \
     } \
-} while (0);
+} while (0)
 
 /* Fields for FlashPartInfo->flags */
 
diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index 6143494..fbdbd46 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -33,7 +33,7 @@
 #define DB_PRINT(...) do { \
     fprintf(stderr,  ": %s: ", __func__); \
     fprintf(stderr, ## __VA_ARGS__); \
-    } while (0);
+    } while (0)
 #else
     #define DB_PRINT(...)
 #endif
diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
index 268e435..07b462d 100644
--- a/hw/char/stm32f2xx_usart.c
+++ b/hw/char/stm32f2xx_usart.c
@@ -34,7 +34,7 @@
     if (STM_USART_ERR_DEBUG >= lvl) { \
         qemu_log("%s: " fmt, __func__, ## args); \
     } \
-} while (0);
+} while (0)
 
 #define DB_PRINT(fmt, args...) DB_PRINT_L(1, fmt, ## args)
 
diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index e069c44..cafd9f4 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -63,7 +63,7 @@
     if (DEBUG_CG3) { \
         printf("CG3: " fmt , ## __VA_ARGS__); \
     } \
-} while (0);
+} while (0)
 
 #define TYPE_CG3 "cgthree"
 #define CG3(obj) OBJECT_CHECK(CG3State, (obj), TYPE_CG3)
diff --git a/hw/display/dpcd.c b/hw/display/dpcd.c
index ce92ff6..943002b 100644
--- a/hw/display/dpcd.c
+++ b/hw/display/dpcd.c
@@ -39,7 +39,7 @@
     if (DEBUG_DPCD) {                                                          \
         qemu_log("dpcd: " fmt, ## __VA_ARGS__);                                \
     }                                                                          \
-} while (0);
+} while (0)
 
 #define DPCD_READABLE_AREA                      0x600
 
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 561f828..ead4e1a 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -34,7 +34,7 @@
     if (DEBUG_DP) {                                                            \
         qemu_log("xlnx_dp: " fmt , ## __VA_ARGS__);                            \
     }                                                                          \
-} while (0);
+} while (0)
 
 /*
  * Register offset for DP.
diff --git a/hw/dma/pl330.c b/hw/dma/pl330.c
index 32cf839..d071049 100644
--- a/hw/dma/pl330.c
+++ b/hw/dma/pl330.c
@@ -29,7 +29,7 @@
     if (PL330_ERR_DEBUG >= lvl) {\
         fprintf(stderr, "PL330: %s:" fmt, __func__, ## args);\
     } \
-} while (0);
+} while (0)
 
 #define DB_PRINT(fmt, args...) DB_PRINT_L(1, fmt, ## args)
 
diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index 3b10523..12bb2e3 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -43,7 +43,7 @@
     if (XLNX_ZYNQ_DEVCFG_ERR_DEBUG) { \
         qemu_log("%s: " fmt, __func__, ## args); \
     } \
-} while (0);
+} while (0)
 
 REG32(CTRL, 0x00)
     FIELD(CTRL,     FORCE_RST,          31,  1) /* Not supported, wr ignored */
diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
index 8ceb21d..077c7da 100644
--- a/hw/dma/xlnx_dpdma.c
+++ b/hw/dma/xlnx_dpdma.c
@@ -34,7 +34,7 @@
     if (DEBUG_DPDMA) {                                                         \
         qemu_log("xlnx_dpdma: " fmt , ## __VA_ARGS__);                         \
     }                                                                          \
-} while (0);
+} while (0)
 
 /*
  * Registers offset for DPDMA.
diff --git a/hw/i2c/i2c-ddc.c b/hw/i2c/i2c-ddc.c
index 6b92e95..199dac9 100644
--- a/hw/i2c/i2c-ddc.c
+++ b/hw/i2c/i2c-ddc.c
@@ -30,7 +30,7 @@
     if (DEBUG_I2CDDC) {                                                        \
         qemu_log("i2c-ddc: " fmt , ## __VA_ARGS__);                            \
     }                                                                          \
-} while (0);
+} while (0)
 
 /* Structure defining a monitor's characteristics in a
  * readable format: this should be passed to build_edid_blob()
diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
index 1182745..b4cacd6 100644
--- a/hw/misc/auxbus.c
+++ b/hw/misc/auxbus.c
@@ -40,7 +40,7 @@
     if (DEBUG_AUX) {                                                           \
         qemu_log("aux: " fmt , ## __VA_ARGS__);                                \
     }                                                                          \
-} while (0);
+} while (0)
 
 #define TYPE_AUXTOI2C "aux-to-i2c-bridge"
 #define AUXTOI2C(obj) OBJECT_CHECK(AUXTOI2CState, (obj), TYPE_AUXTOI2C)
diff --git a/hw/misc/macio/mac_dbdma.c b/hw/misc/macio/mac_dbdma.c
index 0eddf2e..1b2a69b 100644
--- a/hw/misc/macio/mac_dbdma.c
+++ b/hw/misc/macio/mac_dbdma.c
@@ -52,7 +52,7 @@
     if (DEBUG_DBDMA) { \
         printf("DBDMA: " fmt , ## __VA_ARGS__); \
     } \
-} while (0);
+} while (0)
 
 #define DBDMA_DPRINTFCH(ch, fmt, ...) do { \
     if (DEBUG_DBDMA) { \
@@ -60,7 +60,7 @@
             printf("DBDMA[%02x]: " fmt , (ch)->channel, ## __VA_ARGS__); \
         } \
     } \
-} while (0);
+} while (0)
 
 /*
  */
diff --git a/hw/misc/mmio_interface.c b/hw/misc/mmio_interface.c
index 894e980..3b0e203 100644
--- a/hw/misc/mmio_interface.c
+++ b/hw/misc/mmio_interface.c
@@ -39,7 +39,7 @@ static uint64_t mmio_interface_counter;
     if (DEBUG_MMIO_INTERFACE) {                                                \
         qemu_log("mmio_interface: 0x%" PRIX64 ": " fmt, s->id, ## __VA_ARGS__);\
     }                                                                          \
-} while (0);
+} while (0)
 
 static void mmio_interface_init(Object *obj)
 {
diff --git a/hw/misc/stm32f2xx_syscfg.c b/hw/misc/stm32f2xx_syscfg.c
index 7c45833..7f10195 100644
--- a/hw/misc/stm32f2xx_syscfg.c
+++ b/hw/misc/stm32f2xx_syscfg.c
@@ -34,7 +34,7 @@
     if (STM_SYSCFG_ERR_DEBUG >= lvl) { \
         qemu_log("%s: " fmt, __func__, ## args); \
     } \
-} while (0);
+} while (0)
 
 #define DB_PRINT(fmt, args...) DB_PRINT_L(1, fmt, ## args)
 
diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index 44304d4..d6bdd02 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -30,7 +30,7 @@
             fprintf(stderr,  ": %s: ", __func__); \
             fprintf(stderr, ## __VA_ARGS__); \
         } \
-    } while (0);
+    } while (0)
 
 #define XILINX_LOCK_KEY 0x767b
 #define XILINX_UNLOCK_KEY 0xdf0d
diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 3943187..0fa4b0d 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -34,7 +34,7 @@
 #define DB_PRINT(...) do { \
     fprintf(stderr,  ": %s: ", __func__); \
     fprintf(stderr, ## __VA_ARGS__); \
-    } while (0);
+    } while (0)
 #else
     #define DB_PRINT(...)
 #endif
diff --git a/hw/ssi/mss-spi.c b/hw/ssi/mss-spi.c
index d60daba..185e1a3 100644
--- a/hw/ssi/mss-spi.c
+++ b/hw/ssi/mss-spi.c
@@ -35,7 +35,7 @@
     if (MSS_SPI_ERR_DEBUG >= lvl) { \
         qemu_log("%s: " fmt "\n", __func__, ## args); \
     } \
-} while (0);
+} while (0)
 
 #define DB_PRINT(fmt, args...) DB_PRINT_L(1, fmt, ## args)
 
diff --git a/hw/ssi/stm32f2xx_spi.c b/hw/ssi/stm32f2xx_spi.c
index 26a1b4d..69514da 100644
--- a/hw/ssi/stm32f2xx_spi.c
+++ b/hw/ssi/stm32f2xx_spi.c
@@ -35,7 +35,7 @@
     if (STM_SPI_ERR_DEBUG >= lvl) { \
         qemu_log("%s: " fmt, __func__, ## args); \
     } \
-} while (0);
+} while (0)
 
 #define DB_PRINT(fmt, args...) DB_PRINT_L(1, fmt, ## args)
 
diff --git a/hw/ssi/xilinx_spi.c b/hw/ssi/xilinx_spi.c
index 33482f0..83585bc 100644
--- a/hw/ssi/xilinx_spi.c
+++ b/hw/ssi/xilinx_spi.c
@@ -36,7 +36,7 @@
 #define DB_PRINT(...) do { \
     fprintf(stderr,  ": %s: ", __func__); \
     fprintf(stderr, ## __VA_ARGS__); \
-    } while (0);
+    } while (0)
 #else
     #define DB_PRINT(...)
 #endif
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index d8187fa..85c5d0c 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -43,7 +43,7 @@
         fprintf(stderr,  ": %s: ", __func__); \
         fprintf(stderr, ## __VA_ARGS__); \
     } \
-} while (0);
+} while (0)
 
 /* config register */
 #define R_CONFIG            (0x00 / 4)
diff --git a/hw/timer/a9gtimer.c b/hw/timer/a9gtimer.c
index ce1dc63..96d534d 100644
--- a/hw/timer/a9gtimer.c
+++ b/hw/timer/a9gtimer.c
@@ -37,7 +37,7 @@
         fprintf(stderr,  ": %s: ", __func__); \
         fprintf(stderr, ## __VA_ARGS__); \
     } \
-} while (0);
+} while (0)
 
 #define DB_PRINT(...) DB_PRINT_L(0, ## __VA_ARGS__)
 
diff --git a/hw/timer/cadence_ttc.c b/hw/timer/cadence_ttc.c
index 5e65fdb..1005640 100644
--- a/hw/timer/cadence_ttc.c
+++ b/hw/timer/cadence_ttc.c
@@ -24,7 +24,7 @@
 #define DB_PRINT(...) do { \
     fprintf(stderr,  ": %s: ", __func__); \
     fprintf(stderr, ## __VA_ARGS__); \
-    } while (0);
+    } while (0)
 #else
     #define DB_PRINT(...)
 #endif
diff --git a/hw/timer/mss-timer.c b/hw/timer/mss-timer.c
index 60f1213..4f81457 100644
--- a/hw/timer/mss-timer.c
+++ b/hw/timer/mss-timer.c
@@ -36,7 +36,7 @@
     if (MSS_TIMER_ERR_DEBUG >= lvl) { \
         qemu_log("%s: " fmt "\n", __func__, ## args); \
     } \
-} while (0);
+} while (0)
 
 #define DB_PRINT(fmt, args...) DB_PRINT_L(1, fmt, ## args)
 
diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
index e5f5e14..58fc7b1 100644
--- a/hw/timer/stm32f2xx_timer.c
+++ b/hw/timer/stm32f2xx_timer.c
@@ -34,7 +34,7 @@
     if (STM_TIMER_ERR_DEBUG >= lvl) { \
         qemu_log("%s: " fmt, __func__, ## args); \
     } \
-} while (0);
+} while (0)
 
 #define DB_PRINT(fmt, args...) DB_PRINT_L(1, fmt, ## args)
 
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 149fae6..29142f3 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -38,7 +38,7 @@
     if (DEBUG_TPM) { \
         fprintf(stderr, fmt, ## __VA_ARGS__); \
     } \
-} while (0);
+} while (0)
 
 #define TYPE_TPM_PASSTHROUGH "tpm-passthrough"
 #define TPM_PASSTHROUGH(obj) \
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 561384c..8b5eb01 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -90,7 +90,7 @@ typedef struct TPMState {
     if (DEBUG_TIS) { \
         printf(fmt, ## __VA_ARGS__); \
     } \
-} while (0);
+} while (0)
 
 /* tis registers */
 #define TPM_TIS_REG_ACCESS                0x00
diff --git a/migration/rdma.c b/migration/rdma.c
index ca56594..9d5a424 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -88,7 +88,7 @@ static uint32_t known_capabilities = RDMA_CAPABILITY_PIN_ALL;
             } \
             return rdma->error_state; \
         } \
-    } while (0);
+    } while (0)
 
 /*
  * A work request ID is 64-bits and we split up these bits
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index ba94f7d..cba5587 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -400,7 +400,7 @@ static void unallocated_encoding(DisasContext *s)
                       "at pc=%016" PRIx64 "\n",                          \
                       __FILE__, __LINE__, insn, s->pc - 4);              \
         unallocated_encoding(s);                                         \
-    } while (0);
+    } while (0)
 
 static void init_tmp_a64_array(DisasContext *s)
 {
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 9b8b59f..6a18a41 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -58,7 +58,7 @@
     if (DEBUG_KVM) {                          \
         fprintf(stderr, fmt, ## __VA_ARGS__); \
     }                                         \
-} while (0);
+} while (0)
 
 #define kvm_vm_check_mem_attr(s, attr) \
     kvm_vm_check_attr(s, KVM_S390_VM_MEM_CTRL, attr)
diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
index d5ca5b6..ac52abd 100644
--- a/tests/acpi-utils.h
+++ b/tests/acpi-utils.h
@@ -32,7 +32,7 @@ typedef struct {
     do {                                        \
         memread(addr, &field, sizeof(field));   \
         addr += sizeof(field);                  \
-    } while (0);
+    } while (0)
 
 #define ACPI_READ_ARRAY_PTR(arr, length, addr)  \
     do {                                        \
@@ -40,7 +40,7 @@ typedef struct {
         for (idx = 0; idx < length; ++idx) {    \
             ACPI_READ_FIELD(arr[idx], addr);    \
         }                                       \
-    } while (0);
+    } while (0)
 
 #define ACPI_READ_ARRAY(arr, addr)                               \
     ACPI_READ_ARRAY_PTR(arr, sizeof(arr) / sizeof(arr[0]), addr)
@@ -56,7 +56,7 @@ typedef struct {
         ACPI_READ_FIELD((table)->oem_revision, addr);            \
         ACPI_READ_ARRAY((table)->asl_compiler_id, addr);         \
         ACPI_READ_FIELD((table)->asl_compiler_revision, addr);   \
-    } while (0);
+    } while (0)
 
 #define ACPI_ASSERT_CMP(actual, expected) do { \
     char ACPI_ASSERT_CMP_str[5] = {}; \
@@ -77,7 +77,7 @@ typedef struct {
         ACPI_READ_FIELD((field).bit_offset, addr);   \
         ACPI_READ_FIELD((field).access_width, addr); \
         ACPI_READ_FIELD((field).address, addr);      \
-    } while (0);
+    } while (0)
 
 
 uint8_t acpi_calc_checksum(const uint8_t *data, int len);
diff --git a/tests/tcg/test-mmap.c b/tests/tcg/test-mmap.c
index 3982fa2..cdefadf 100644
--- a/tests/tcg/test-mmap.c
+++ b/tests/tcg/test-mmap.c
@@ -39,7 +39,7 @@ do                                                             \
     fprintf (stderr, "FAILED at %s:%d\n", __FILE__, __LINE__); \
     exit (EXIT_FAILURE);                                       \
   }                                                            \
-} while (0);
+} while (0)
 
 unsigned char *dummybuf;
 static unsigned int pagesize;
diff --git a/ui/sdl_zoom_template.h b/ui/sdl_zoom_template.h
index 3bb508b..6a424ad 100644
--- a/ui/sdl_zoom_template.h
+++ b/ui/sdl_zoom_template.h
@@ -34,22 +34,22 @@
 #define setRed(r, pcolor) do { \
     *pcolor = ((*pcolor) & (~(dpf->Rmask))) + \
               (((r) & (dpf->Rmask >> dpf->Rshift)) << dpf->Rshift); \
-} while (0);
+} while (0)
 
 #define setGreen(g, pcolor) do { \
     *pcolor = ((*pcolor) & (~(dpf->Gmask))) + \
               (((g) & (dpf->Gmask >> dpf->Gshift)) << dpf->Gshift); \
-} while (0);
+} while (0)
 
 #define setBlue(b, pcolor) do { \
     *pcolor = ((*pcolor) & (~(dpf->Bmask))) + \
               (((b) & (dpf->Bmask >> dpf->Bshift)) << dpf->Bshift); \
-} while (0);
+} while (0)
 
 #define setAlpha(a, pcolor) do { \
     *pcolor = ((*pcolor) & (~(dpf->Amask))) + \
               (((a) & (dpf->Amask >> dpf->Ashift)) << dpf->Ashift); \
-} while (0);
+} while (0)
 
 static void glue(sdl_zoom_rgb, BPP)(SDL_Surface *src, SDL_Surface *dst, int smooth,
                                    SDL_Rect *dst_rect)
-- 
1.8.3.1
