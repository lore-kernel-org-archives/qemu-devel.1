Received: from eggs.gnu.org ([2001:4830:134:3::10]:49608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dkPV4-0001as-E7
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 02:50:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dkPV3-0006l3-3f
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 02:50:50 -0400
References: <20170822131832.20191-1-pbonzini@redhat.com>
	<20170822131832.20191-10-pbonzini@redhat.com>
	<20170823050156.GC21343@lemon>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8e0b0367-5920-ef02-ea7d-476507b96eb5@redhat.com>
Date: Wed, 23 Aug 2017 08:50:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170823050156.GC21343@lemon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/10] scsi: add multipath support to
 qemu-pr-helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On 23/08/2017 07:01, Fam Zheng wrote:
> On Tue, 08/22 15:18, Paolo Bonzini wrote:
>> Proper support of persistent reservation for multipath devices requires
>> communication with the multipath daemon, so that the reservation is
>> registered and applied when a path comes up.  The device mapper
>> utilities provide a library to do so; this patch makes qemu-pr-helper.c
>> detect multipath devices and, when one is found, delegate the operation
>> to libmpathpersist.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  Makefile              |   3 +
>>  configure             |  57 ++++++++-
>>  docs/pr-manager.rst   |  27 +++++
>>  include/scsi/utils.h  |   6 +
>>  scsi/qemu-pr-helper.c | 311 +++++++++++++++++++++++++++++++++++++++++++++++++-
>>  scsi/utils.c          |  15 +++
>>  6 files changed, 414 insertions(+), 5 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index bfd4f69ecd..f1acaad05b 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -388,6 +388,9 @@ fsdev/virtfs-proxy-helper$(EXESUF): fsdev/virtfs-proxy-helper.o fsdev/9p-marshal
>>  fsdev/virtfs-proxy-helper$(EXESUF): LIBS += -lcap
>>  
>>  scsi/qemu-pr-helper$(EXESUF): scsi/qemu-pr-helper.o scsi/utils.o $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
>> +ifdef CONFIG_MPATH
>> +scsi/qemu-pr-helper$(EXESUF): LIBS += -ludev -lmultipath -lmpathpersist
>> +endif
>>  
>>  qemu-img-cmds.h: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
>>  	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
>> diff --git a/configure b/configure
>> index 772aff18d6..d3c9371f7c 100755
>> --- a/configure
>> +++ b/configure
>> @@ -286,6 +286,7 @@ pixman=""
>>  sdl=""
>>  sdlabi=""
>>  virtfs=""
>> +mpath=""
> 
> Whole patch: s/\<mpath\>/pr-helper/ ?

No, the helper can work without multipath support.  The mpath variable
is about supporting multipath in the helper.

Paolo

>>  vnc="yes"
>>  sparse="no"
>>  vde=""
>> @@ -948,6 +949,10 @@ for opt do
>>    ;;
>>    --enable-virtfs) virtfs="yes"
>>    ;;
>> +  --disable-mpath) mpath="no"
>> +  ;;
>> +  --enable-mpath) mpath="yes"
>> +  ;;
>>    --disable-vnc) vnc="no"
>>    ;;
>>    --enable-vnc) vnc="yes"
>> @@ -1491,6 +1496,7 @@ disabled with --disable-FEATURE, default is enabled if available:
>>    vnc-png         PNG compression for VNC server
>>    cocoa           Cocoa UI (Mac OS X only)
>>    virtfs          VirtFS
>> +  mpath           Multipath persistent reservation passthrough
>>    xen             xen backend driver support
>>    xen-pci-passthrough
>>    brlapi          BrlAPI (Braile)
>> @@ -3336,6 +3342,29 @@ else
>>  fi
>>  
>>  ##########################################
>> +# libmpathpersist probe
>> +
>> +if test "$mpath" != "no" ; then
>> +  cat > $TMPC <<EOF
>> +#include <libudev.h>
>> +#include <mpath_persist.h>
>> +unsigned mpath_mx_alloc_len = 1024;
>> +int logsink;
>> +int main(void) {
>> +    struct udev *udev = udev_new();
>> +    mpath_lib_init(udev);
>> +}
>> +EOF
>> +  if compile_prog "" "-ludev -lmultipath -lmpathpersist" ; then
>> +    mpathpersist=yes
>> +  else
>> +    mpathpersist=no
>> +  fi
>> +else
>> +  mpathpersist=no
>> +fi
>> +
>> +##########################################
>>  # libcap probe
>>  
>>  if test "$cap" != "no" ; then
>> @@ -5070,16 +5099,34 @@ if test "$want_tools" = "yes" ; then
>>    fi
>>  fi
>>  if test "$softmmu" = yes ; then
>> -  if test "$virtfs" != no ; then
>> -    if test "$cap" = yes && test "$linux" = yes && test "$attr" = yes ; then
>> +  if test "$linux" = yes; then
>> +    if test "$virtfs" != no && test "$cap" = yes && test "$attr" = yes ; then
>>        virtfs=yes
>>        tools="$tools fsdev/virtfs-proxy-helper\$(EXESUF)"
>>      else
>>        if test "$virtfs" = yes; then
>> -        error_exit "VirtFS is supported only on Linux and requires libcap devel and libattr devel"
>> +        error_exit "VirtFS requires libcap devel and libattr devel"
>>        fi
>>        virtfs=no
>>      fi
>> +    if test "$mpath" != no && test "$mpathpersist" = yes ; then
>> +      mpath=yes
>> +      tools="$tools mpath/qemu-mpath-helper\$(EXESUF)"
> 
> scsi/qemu-pr-helper?
> 
>> +    else
>> +      if test "$mpath" = yes; then
>> +        error_exit "Multipath requires libmpathpersist devel"
>> +      fi
>> +      mpath=no
>> +    fi
>> +  else
>> +    if test "$virtfs" = yes; then
>> +      error_exit "VirtFS is supported only on Linux"
>> +    fi
>> +    virtfs=no
>> +    if test "$mpath" = yes; then
>> +      error_exit "Multipath is supported only on Linux"
>> +    fi
>> +    mpath=no
>>    fi
>>  fi
>>  
>> @@ -5326,6 +5373,7 @@ echo "Audio drivers     $audio_drv_list"
>>  echo "Block whitelist (rw) $block_drv_rw_whitelist"
>>  echo "Block whitelist (ro) $block_drv_ro_whitelist"
>>  echo "VirtFS support    $virtfs"
>> +echo "Multipath support $mpath"
>>  echo "VNC support       $vnc"
>>  if test "$vnc" = "yes" ; then
>>      echo "VNC SASL support  $vnc_sasl"
>> @@ -5773,6 +5821,9 @@ fi
>>  if test "$virtfs" = "yes" ; then
>>    echo "CONFIG_VIRTFS=y" >> $config_host_mak
>>  fi
>> +if test "$mpath" = "yes" ; then
>> +  echo "CONFIG_MPATH=y" >> $config_host_mak
>> +fi
>>  if test "$vhost_scsi" = "yes" ; then
>>    echo "CONFIG_VHOST_SCSI=y" >> $config_host_mak
>>  fi
> 
> Fam
> 
