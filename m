Received: from eggs.gnu.org ([2001:4830:134:3::10]:47916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dorwB-0003f1-IX
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:01:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dorw1-0003mT-SP
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:01:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dorw1-0003ld-Kt
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:01:05 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  4 Sep 2017 16:00:56 +0200
Message-Id: <1504533662-198084-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 0/6] generalize parsing of cpu_model (x86/arm)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Andrew Jones <drjones@redhat.com>, Richard Henderson <rth@twiddle.net>

Issue 1:                                                                         
Some callers call CPUClass->parse_features manually to convert                   
'-cpu cpufoo,featurestr' string to cpu type and featurestr                       
into a set of global properties and then do controlled                           
cpu creation with setting properties and completing it with realize.             
That's a lot of code duplication as they all are practically                     
reimplement the same parsing logic.                                              
                                                                                 
Some use cpu_generic_init() instead which does the same parsing                  
along with creation/realizing cpu within one wrapper.                            
                                                                                 
And some trying to switch to controlled cpu creation,                            
implement object_new()/set properties/realize steps                              
but forget feature parsing logic witch leads to 'bugs'                           
commit (00909b585 hw/arm/integratorcp: Support specifying features via -cpu)     
                                                                                 
Issue 2:                                                                         
Default cpu model selection logic is spread over  all board's                    
machine_init() fuctions but it's basicallyi hardcodes default                    
cpu model string in init function.                                               
                                                                                 
 if (!cpu_model) {                                                               
     cpu_model = "some cpu model string";                                        
 }                                                                               
                                                                                 
and written in different ways.                                                   
it forces machine_init callbacks to parse cpu_model string                       
either by using cpu_generic_init() or by manually calling                        
cpu_class_by_name()/CPUClass::parse_features to perform                          
name to cpu type translation.

This series moves -cpu option parsing to generic machine code                    
that removes some of code duplication and makes cpus creation                    
process more generic/simple:                                                            
                                                                                 
 * unify default (fallback) cpu type handling by replacing                       
   hardcoded cpu_model strings with cpu type directly in                         
                                                                                 
   machine_foo_class_init() {                                                    
       MachineClass::default_cpu_type = BOARD_DEFAULT_CPU_TYPE                   
   }                                                                             
                                                                                 
   which allows to generalize move cpu model parsing instead of                  
   parsing it in each board.                                                     
                                                                                 
 * make generic machine vl.c parse cpu_model into properties/cpu_type            
   and let boards use cpu_type without any cpu_model prasing.                    
   Generic parsing will kick in only if board advertises its support             
   by setting MachineClass::default_cpu_type to a cpu type.                      
                                                                                 
PS:                                                                              
I intend make tree-wide conversion but as one series it's too many patches,       
so I'm splitting out it into an intial series that implements generic            
part and several patchsets that will do per target conversion.                   
                                                                                 
As part of initial series x86 and ARM targets conversion is included             
to showcase generalization usage. Per target conversions are done
as 1 patch per target, it might be too much for targets that have lots
of boards (ARM) so let me know if you'd like to split it on per board
basis (then I'll respin it as separate series on top of generic patches)

github tree for testing:
https://github.com/imammedo/qemu.git default_machine_cpu_type_PC_ARM

CC: Eduardo Habkost <ehabkost@redhat.com>
CC: Andrew Jones <drjones@redhat.com>
CC: Richard Henderson <rth@twiddle.net>

Igor Mammedov (6):
  qom: cpus: split cpu_generic_init() on feature parsing and cpu
    creation parts
  cpu: make cpu_generic_init() abort QEMU on error
  cpu: rename cpu_parse_features() to cpu_parse_cpu_model()
  vl.c: convert cpu_model to cpu type and set of global properties
    before machine_init()
  pc: use generic cpu_model parsing
  arm: drop intermadiate cpu_model -> cpu type parsing and use cpu type
    directly

 include/hw/arm/armv7m.h        |  2 +-
 include/hw/arm/aspeed_soc.h    |  2 +-
 include/hw/arm/stm32f205_soc.h |  2 +-
 include/hw/boards.h            |  6 ++++++
 include/qom/cpu.h              | 22 +++++++++++++++++++
 target/arm/cpu.h               |  3 +++
 target/i386/cpu.h              |  9 ++++++++
 bsd-user/main.c                |  4 ----
 hw/alpha/dp264.c               |  4 ----
 hw/arm/armv7m.c                | 40 +++++-----------------------------
 hw/arm/aspeed_soc.c            | 13 +++++------
 hw/arm/collie.c                | 10 +++------
 hw/arm/exynos4210.c            |  6 +-----
 hw/arm/gumstix.c               |  5 +++--
 hw/arm/highbank.c              | 10 ++++-----
 hw/arm/integratorcp.c          | 30 ++------------------------
 hw/arm/mainstone.c             |  9 ++++----
 hw/arm/mps2.c                  | 17 ++++++---------
 hw/arm/musicpal.c              | 11 ++--------
 hw/arm/netduino2.c             |  2 +-
 hw/arm/nseries.c               |  4 +++-
 hw/arm/omap1.c                 | 11 ++--------
 hw/arm/omap2.c                 |  8 ++-----
 hw/arm/omap_sx1.c              |  5 ++++-
 hw/arm/palm.c                  |  5 +++--
 hw/arm/pxa2xx.c                | 18 ++++------------
 hw/arm/realview.c              | 25 +++++----------------
 hw/arm/spitz.c                 | 12 ++++++-----
 hw/arm/stellaris.c             | 16 ++++++--------
 hw/arm/stm32f205_soc.c         |  4 ++--
 hw/arm/strongarm.c             | 15 +++----------
 hw/arm/tosa.c                  |  4 ----
 hw/arm/versatilepb.c           | 15 +++----------
 hw/arm/vexpress.c              | 32 +++++++++------------------
 hw/arm/virt.c                  | 46 ++++++++-------------------------------
 hw/arm/xilinx_zynq.c           | 10 ++-------
 hw/arm/z2.c                    |  9 +++-----
 hw/i386/pc.c                   | 41 +++++------------------------------
 hw/i386/pc_piix.c              |  4 +---
 hw/lm32/lm32_boards.c          |  8 -------
 hw/lm32/milkymist.c            |  4 ----
 hw/m68k/an5206.c               |  4 ----
 hw/m68k/mcf5208.c              |  4 ----
 hw/mips/cps.c                  |  4 ----
 hw/mips/mips_fulong2e.c        |  4 ----
 hw/mips/mips_jazz.c            |  4 ----
 hw/mips/mips_malta.c           |  4 ----
 hw/mips/mips_mipssim.c         |  4 ----
 hw/mips/mips_r4k.c             |  4 ----
 hw/moxie/moxiesim.c            |  4 ----
 hw/openrisc/openrisc_sim.c     |  4 ----
 hw/ppc/e500.c                  |  4 ----
 hw/ppc/mac_newworld.c          |  4 ----
 hw/ppc/mac_oldworld.c          |  4 ----
 hw/ppc/ppc440_bamboo.c         |  4 ----
 hw/ppc/ppc4xx_devs.c           |  5 -----
 hw/ppc/prep.c                  |  9 --------
 hw/ppc/virtex_ml507.c          |  4 ----
 hw/sh4/r2d.c                   |  4 ----
 hw/sh4/shix.c                  |  4 ----
 hw/sparc/leon3.c               |  4 ----
 hw/sparc/sun4m.c               |  4 ----
 hw/sparc64/sparc64.c           |  4 ----
 hw/tricore/tricore_testboard.c |  4 ----
 hw/unicore32/puv3.c            |  4 ----
 hw/xtensa/sim.c                |  5 -----
 hw/xtensa/xtfpga.c             |  5 -----
 linux-user/main.c              |  4 ----
 qom/cpu.c                      | 49 ++++++++++++++++++++++++++----------------
 target/arm/cpu.c               |  2 +-
 target/i386/cpu.c              |  3 ---
 vl.c                           | 10 +++++++++
 72 files changed, 198 insertions(+), 485 deletions(-)

-- 
2.7.4
