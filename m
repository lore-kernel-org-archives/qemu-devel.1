Received: from eggs.gnu.org ([2001:4830:134:3::10]:58792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1ebNjP-00034U-27
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 04:40:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1ebNjK-0007Qy-3H
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 04:40:35 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196]:39021)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1ebNjJ-0007EI-JU
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 04:40:30 -0500
From: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
Message-ID: <c2d2d787-8e45-f26a-54cf-9670a27dc836@lauterbach.com>
Date: Tue, 16 Jan 2018 10:40:10 +0100
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH RFC] target-arm:Add a dynamic XML-description
 of the cp-registers to GDB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: Khaled Jmal <khaled.jmal@lauterbach.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

[PATCH RFC] target-arm:Add a dynamic XML-description of the cp-registers 
to GDB

This patch offers to GDB the ability to read/write all the coprocessor
registers for ARM and ARM64 by generating dynamically an XML-description for
these registers.

- gdbstub.c :
         *Extend the get_feature_xml() to handle the dynamic XML 
generation for
            architectures that support this 
(gdb_coprocessor_dynnamic_xml == true)
         *Extend the gdb_write_register() and gdb_read_register() to 
handle the
           write and the read of these registers.
- include/qom/cpu.h:
         *Add a new structure "XMLDynamicDescription".
         *Declare the new variables and function pointers.
- target/arm/cpu.c:
         *Initialize the new variables and function pointers for ARM.
- target/arm/cpu.h:
         *Declare the new read, write and XML dynamic generation functions.
         *Declare the write_raw_cp_reg() as I have changed it to non static.
- target/arm/gdbstub.c:
         *Define the new functions for ARM:
             arm_generate_xml(): is called for each register of the 
hashtable cp_regs
                          to generate the right XML "<reg />" line for it.
             arm_get_feature_xml_dynamically(): generate the XML 
dynamically.
             arm_cpu_gdb_read_cpregister(): To read the coprocessor 
registers.
             arm_cpu_gdb_write_cpregister(): To write the coprocessor 
registers.

This patch is tagged as [RFC] because I need help to review the 
following points:
*I only take the registers that (!(ri->type & (ARM_CP_NO_RAW|ARM_CP_ALIAS)))
So, am I covering all the Coprocessor registers with that?
*For the ARM64, should I differentiate the registers that have two views 
(32 and 64)
Maybe by adding in the XML description a "32" tag for the registers name 
for the
32bit view and a "64" for the 64bit view.
*How to properly handle the secure and the non secure views?

Signed-off-by: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
---
  gdbstub.c            | 18 +++++++++++
  include/qom/cpu.h    | 19 +++++++++++
  target/arm/cpu.c     |  5 +++
  target/arm/cpu.h     |  6 +++-
  target/arm/gdbstub.c | 90 
++++++++++++++++++++++++++++++++++++++++++++++++++++
  target/arm/helper.c  |  3 +-
  6 files changed, 138 insertions(+), 3 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index f1d5148..b0124c8 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -670,10 +670,20 @@ static const char *get_feature_xml(const char *p, 
const char **newp,
                  pstrcat(target_xml, sizeof(target_xml), r->xml);
                  pstrcat(target_xml, sizeof(target_xml), "\"/>");
              }
+            if (cc->gdb_coprocessor_dynamic_xml) {
+                pstrcat(target_xml, sizeof(target_xml), "<xi:include 
href=\"");
+                pstrcat(target_xml, sizeof(target_xml), \
+                        "coprocessor_dynamic.xml");
+                pstrcat(target_xml, sizeof(target_xml), "\"/>");
+            }
              pstrcat(target_xml, sizeof(target_xml), "</target>");
          }
          return target_xml;
      }
+    if (strncmp(p, "coprocessor_dynamic.xml", len) == 0) {
+        CPUState *cpu = first_cpu;
+        return cc->get_feature_xml_dynamically(cpu);
+    }
      for (i = 0; ; i++) {
          name = xml_builtin[i][0];
          if (!name || (strncmp(name, p, len) == 0 && strlen(name) == len))
@@ -697,6 +707,10 @@ static int gdb_read_register(CPUState *cpu, uint8_t 
*mem_buf, int reg)
              return r->get_reg(env, mem_buf, reg - r->base_reg);
          }
      }
+
+    if (reg < cpu->gdb_num_regs + cc->gdb_num_cpregs) {
+        return cc->gdb_read_cpregister(cpu, mem_buf, reg - 
cpu->gdb_num_regs);
+    }
      return 0;
  }

@@ -715,6 +729,10 @@ static int gdb_write_register(CPUState *cpu, 
uint8_t *mem_buf, int reg)
              return r->set_reg(env, mem_buf, reg - r->base_reg);
          }
      }
+
+    if (reg < cpu->gdb_num_regs + cc->gdb_num_cpregs) {
+        return cc->gdb_write_cpregister(cpu, mem_buf, reg - 
cpu->gdb_num_regs);
+    }
      return 0;
  }

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 93bd546..f40ee59 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -76,6 +76,19 @@ typedef void (*CPUUnassignedAccess)(CPUState *cpu, 
hwaddr addr,
  struct TranslationBlock;

  /**
+ * XMLDynamicDescription:
+ * @desc: Contains the XML descriptions.
+ * @num_cpregs: Number of the Coprocessor registers seen by GDB.
+ * @xml_cpregs_ordred_keys: Array that contains the corresponding Key of
+ * a given cpreg with the same order of the cpreg in the XML description.
+ */
+typedef struct XMLDynamicDescription {
+    char * desc;
+    int num_cpregs;
+    uint32_t *xml_cpregs_ordred_keys;
+} XMLDynamicDescription;
+
+/**
   * CPUClass:
   * @class_by_name: Callback to map -cpu command line model name to an
   * instantiatable CPU type.
@@ -196,6 +209,12 @@ typedef struct CPUClass {

      const struct VMStateDescription *vmsd;
      const char *gdb_core_xml_file;
+    bool gdb_coprocessor_dynamic_xml;
+    XMLDynamicDescription dyn_xml;
+    int gdb_num_cpregs;
+    char * (*get_feature_xml_dynamically)(CPUState *cpu);
+    int (*gdb_read_cpregister)(CPUState *cpu, uint8_t *buf, int reg);
+    int (*gdb_write_cpregister)(CPUState *cpu, uint8_t *buf, int reg);
      gchar * (*gdb_arch_name)(CPUState *cpu);

      void (*cpu_exec_enter)(CPUState *cpu);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index cc1856c..00efae4 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1751,6 +1751,11 @@ static void arm_cpu_class_init(ObjectClass *oc, 
void *data)
  #endif
      cc->gdb_num_core_regs = 26;
      cc->gdb_core_xml_file = "arm-core.xml";
+    cc->gdb_coprocessor_dynamic_xml=true;
+    cc->gdb_num_cpregs = 0;
+    cc->get_feature_xml_dynamically = arm_get_feature_xml_dynamically;
+    cc->gdb_read_cpregister = arm_cpu_gdb_read_cpregister;
+    cc->gdb_write_cpregister = arm_cpu_gdb_write_cpregister;
      cc->gdb_arch_name = arm_gdb_arch_name;
      cc->gdb_stop_before_watchpoint = true;
      cc->debug_excp_handler = arm_debug_excp_handler;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9631670..16f84e3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -797,6 +797,9 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState 
*cpu, vaddr addr,

  int arm_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
  int arm_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
+char *arm_get_feature_xml_dynamically(CPUState *cpu);
+int arm_cpu_gdb_read_cpregister(CPUState *cpu, uint8_t *buf, int reg);
+int arm_cpu_gdb_write_cpregister(CPUState *cpu, uint8_t *buf, int reg);

  int arm_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
                               int cpuid, void *opaque);
@@ -2005,7 +2008,8 @@ static inline bool cp_access_ok(int current_el,

  /* Raw read of a coprocessor register (as needed for migration, etc) */
  uint64_t read_raw_cp_reg(CPUARMState *env, const ARMCPRegInfo *ri);
-
+void write_raw_cp_reg(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t v);
  /**
   * write_list_to_cpustate
   * @cpu: ARMCPU
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 04c1208..123da12 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -101,3 +101,93 @@ int arm_cpu_gdb_write_register(CPUState *cs, 
uint8_t *mem_buf, int n)
      /* Unknown register.  */
      return 0;
  }
+
+static void arm_generate_xml(gpointer key, gpointer value, gpointer cs)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+    XMLDynamicDescription *dyn_xml = &cc->dyn_xml;
+    ARMCPRegInfo *ri = value;
+    uint32_t ri_key= *(uint32_t *)key;
+    CPUARMState *env = &cpu->env;
+    char **target_xml=(char **)&(dyn_xml->desc);
+    char *tmp_xml=*target_xml;
+
+    if (!(ri->type & (ARM_CP_NO_RAW|ARM_CP_ALIAS))) {
+        if (cpreg_field_is_64bit(ri)){
+            if (arm_feature(env, ARM_FEATURE_AARCH64)) {
+                *target_xml=g_strconcat(*target_xml, "<reg name=\"", \
+                        ri->name, "\" bitsize=\"64\"/>", NULL);
+            } else {
+                return;
+            }
+        } else {
+            *target_xml=g_strconcat(*target_xml, "<reg name=\"", \
+                    ri->name, "\" bitsize=\"32\"/>", NULL);
+        }
+        g_free(tmp_xml);
+        dyn_xml->num_cpregs++;
+        dyn_xml->xml_cpregs_ordred_keys=g_renew(uint32_t, \
+                dyn_xml->xml_cpregs_ordred_keys, dyn_xml->num_cpregs);
+        dyn_xml->xml_cpregs_ordred_keys[dyn_xml->num_cpregs - 1] = ri_key;
+    }
+}
+
+char *arm_get_feature_xml_dynamically(CPUState *cs)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+
+    cc->dyn_xml.num_cpregs=0;
+    cc->dyn_xml.desc=g_strconcat("<?xml version=\"1.0\"?>", \
+                       "<!DOCTYPE target SYSTEM \"gdb-target.dtd\">", \
+                       "<feature name=\"org.gnu.gdb.dynamic.cp\">", NULL);
+    g_hash_table_foreach(cpu->cp_regs, arm_generate_xml, cs);
+    cc->dyn_xml.desc=g_strconcat( cc->dyn_xml.desc, "</feature>", NULL);
+    cc->gdb_num_cpregs=cc->dyn_xml.num_cpregs;
+    return  cc->dyn_xml.desc;
+}
+
+int arm_cpu_gdb_read_cpregister(CPUState *cs, uint8_t *mem_buf, int n)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+    ARMCPRegInfo *ri;
+    CPUARMState *env = &cpu->env;
+    uint32_t key;
+
+    key = cc->dyn_xml.xml_cpregs_ordred_keys[n];
+    ri=(ARMCPRegInfo 
*)get_arm_cp_reginfo(arm_env_get_cpu(env)->cp_regs, key);
+       if (ri) {
+           if(cpreg_field_is_64bit(ri)){
+               return gdb_get_reg64(mem_buf, 
(uint64_t)read_raw_cp_reg(env,ri));
+           } else {
+               return gdb_get_reg32(mem_buf, 
(uint32_t)read_raw_cp_reg(env,ri));
+           }
+       }
+       return 0;
+}
+
+int arm_cpu_gdb_write_cpregister(CPUState *cs, uint8_t *mem_buf, int n)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+    ARMCPRegInfo *ri;
+    CPUARMState *env = &cpu->env;
+    uint32_t tmp_buf,key;
+
+    tmp_buf = ldl_p(mem_buf);
+    key = cc->dyn_xml.xml_cpregs_ordred_keys[n];
+       ri=(ARMCPRegInfo 
*)get_arm_cp_reginfo(arm_env_get_cpu(env)->cp_regs, key);
+       if (ri) {
+        if (!(ri->type & ARM_CP_CONST)) {
+            write_raw_cp_reg(env, ri, tmp_buf);
+            if (cpreg_field_is_64bit(ri)) {
+                return 8;
+            } else {
+                return 4;
+            }
+        }
+    }
+    return 0;
+}
diff --git a/target/arm/helper.c b/target/arm/helper.c
index d1395f9..fedc6bc 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -191,8 +191,7 @@ uint64_t read_raw_cp_reg(CPUARMState *env, const 
ARMCPRegInfo *ri)
      }
  }

-static void write_raw_cp_reg(CPUARMState *env, const ARMCPRegInfo *ri,
-                             uint64_t v)
+void write_raw_cp_reg(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t v)
  {
      /* Raw write of a coprocessor register (as needed for migration, etc).
       * Note that constant registers are treated as write-ignored; the
-- 
1.9.1
