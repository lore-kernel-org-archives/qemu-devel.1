Received: from eggs.gnu.org ([2001:4830:134:3::10]:33160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUawP-0007Ep-9C
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:49:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUawN-0004T6-UZ
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:49:41 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:33080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUawN-0004Si-NC
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:49:39 -0400
Received: by mail-wr0-x232.google.com with SMTP id r103so144284347wrb.0
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 08:49:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1499238885-26161-23-git-send-email-pbonzini@redhat.com>
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
	<1499238885-26161-23-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Jul 2017 16:49:18 +0100
Message-ID: <CAFEAcA-B+aChqZBSnGws7RXheEyg+cutaqvXP8qVgNoUgzQAJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 22/42] configure: factor out list of
 supported Xen/KVM/HAX targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Anthony PERARD <anthony.perard@citrix.com>

On 5 July 2017 at 08:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
> This will be useful when the functions are called, early in the configure
> process, to filter out targets that do not support hardware acceleration.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

> +supported_xen_target() {
> +    test "$xen" = "yes" || return 1
> +    glob "$1" "*-softmmu" || return 1
> +    case "${1%-softmmu}:$cpu" in
> +        arm:arm | aarch64:aarch64 | \
> +        i386:i386 | i386:x86_64 | x86_64:i386 | x86_64:x86_64)
> +            return 0
> +        ;;

This says that arm-on-arm and aarch64-on-aarch64 are supported
Xen targets...

> +    esac
> +    return 1
> +}
> +


>  if [ "$HOST_VARIANT_DIR" != "" ]; then
>      echo "HOST_VARIANT_DIR=$HOST_VARIANT_DIR" >> $config_target_mak
>  fi
> -case "$target_name" in
> -  i386|x86_64)
> -    if test "$xen" = "yes" -a "$target_softmmu" = "yes" ; then
> -      echo "CONFIG_XEN=y" >> $config_target_mak
> -      if test "$xen_pci_passthrough" = yes; then
> +
> +if supported_xen_target $target; then
> +    echo "CONFIG_XEN=y" >> $config_target_mak
> +    if test "$xen_pci_passthrough" = yes; then

...but previously we only enabled CONFIG_XEN on i386 or x86_64
targets.

Alex points out that the shippable builds now fail for aarch64
and arm. (I think that my test machines for aarch64 and arm
don't fail like this because they happen not to have the Xen
headers installed, so the overall "does Xen work on this host"
check fails; the shippable configs do pass that test so they
try to build the Xen code.)

https://app.shippable.com/github/qemu/qemu/runs/267/2/console

exec.o: In function `reclaim_ramblock':
/root/src/github.com/qemu/qemu/exec.c:2071: undefined reference to
`xen_invalidate_map_cache_entry'
exec.o: In function `qemu_map_ram_ptr':
/root/src/github.com/qemu/qemu/exec.c:2177: undefined reference to
`xen_map_cache'
/root/src/github.com/qemu/qemu/exec.c:2174: undefined reference to
`xen_map_cache'
exec.o: In function `qemu_ram_block_from_host':
/root/src/github.com/qemu/qemu/exec.c:2242: undefined reference to
`xen_ram_addr_from_mapcache'
/root/src/github.com/qemu/qemu/exec.c:2242: undefined reference to
`xen_ram_addr_from_mapcache'
exec.o: In function `qemu_ram_ptr_length':
/root/src/github.com/qemu/qemu/exec.c:2210: undefined reference to
`xen_map_cache'
/root/src/github.com/qemu/qemu/exec.c:2207: undefined reference to
`xen_map_cache'
exec.o: In function `address_space_unmap':
/root/src/github.com/qemu/qemu/exec.c:3357: undefined reference to
`xen_invalidate_map_cache_entry'
hw/xen/xen_pt.o: In function `xen_pt_pci_read_config':
/root/src/github.com/qemu/qemu/hw/xen/xen_pt.c:206: undefined
reference to `xen_shutdown_fatal_error'
hw/xen/xen_pt.o: In function `xen_igd_passthrough_isa_bridge_create':
/root/src/github.com/qemu/qemu/hw/xen/xen_pt.c:698: undefined
reference to `igd_passthrough_isa_bridge_create'
hw/xen/xen_pt.o: In function `xen_pt_pci_write_config':
/root/src/github.com/qemu/qemu/hw/xen/xen_pt.c:355: undefined
reference to `xen_shutdown_fatal_error'
hw/xen/xen_pt_config_init.o: In function `xen_pt_status_reg_init':
/root/src/github.com/qemu/qemu/hw/xen/xen_pt_config_init.c:281:
undefined reference to `xen_shutdown_fatal_error'
/root/src/github.com/qemu/qemu/hw/xen/xen_pt_config_init.c:275:
undefined reference to `xen_shutdown_fatal_error'
hw/xen/xen_pt_graphics.o: In function `get_vgabios':
/root/src/github.com/qemu/qemu/hw/xen/xen_pt_graphics.c:135: undefined
reference to `pci_assign_dev_load_option_rom'
collect2: error: ld returned 1 exit status


thanks
-- PMM
