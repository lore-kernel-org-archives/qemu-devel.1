Received: from eggs.gnu.org ([2001:4830:134:3::10]:55794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1cngm7-00022j-OU
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 03:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1cngm4-0001Lt-Hw
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 03:21:43 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:35656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dmitry@daynix.com>) id 1cngm4-0001Km-3H
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 03:21:40 -0400
Received: by mail-wm0-x22b.google.com with SMTP id v186so56681698wmd.0
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 00:21:39 -0700 (PDT)
From: Dmitry Fleytman <dmitry@daynix.com>
Message-Id: <3153E027-1F30-494B-B3CD-8A883B118CA6@daynix.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Tue, 14 Mar 2017 09:21:38 +0200
In-Reply-To: <20170313195547.21466-22-eblake@redhat.com>
References: <20170313195547.21466-1-eblake@redhat.com>
	<20170313195547.21466-22-eblake@redhat.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 21/30] trace: Fix parameter types in
 hw/net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>


Reviewed-by: Dmitry Fleytman <dmitry@daynix.com>

> On 13 Mar 2017, at 21:55 PM, Eric Blake <eblake@redhat.com> wrote:
>=20
> An upcoming patch will let the compiler warn us when we are silently
> losing precision in traces; update the trace definitions to pass
> through the full value at the callsite.  In one case, the trace
> file wants to print bools; update the callers to coerce bit
> operations into appropriate boolean values.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> hw/net/e1000e_core.c | 10 ++++-----
> hw/net/trace-events  | 58 =
++++++++++++++++++++++++++--------------------------
> 2 files changed, 34 insertions(+), 34 deletions(-)
>=20
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index 28c5be1..3b3c231 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -507,8 +507,8 @@ e1000e_rss_get_hash_type(E1000ECore *core, struct =
NetRxPkt *pkt)
>         bool fragment =3D net_rx_pkt_get_ip4_info(pkt)->fragment;
>=20
>         trace_e1000e_rx_rss_ip4(fragment, istcp, core->mac[MRQC],
> -                                =
E1000_MRQC_EN_TCPIPV4(core->mac[MRQC]),
> -                                E1000_MRQC_EN_IPV4(core->mac[MRQC]));
> +                                =
!!E1000_MRQC_EN_TCPIPV4(core->mac[MRQC]),
> +                                =
!!E1000_MRQC_EN_IPV4(core->mac[MRQC]));
>=20
>         if (!fragment && istcp && =
E1000_MRQC_EN_TCPIPV4(core->mac[MRQC])) {
>             return E1000_MRQ_RSS_TYPE_IPV4TCP;
> @@ -536,9 +536,9 @@ e1000e_rss_get_hash_type(E1000ECore *core, struct =
NetRxPkt *pkt)
>                                 ip6info->rss_ex_dst_valid,
>                                 ip6info->rss_ex_src_valid,
>                                 core->mac[MRQC],
> -                                =
E1000_MRQC_EN_TCPIPV6(core->mac[MRQC]),
> -                                =
E1000_MRQC_EN_IPV6EX(core->mac[MRQC]),
> -                                E1000_MRQC_EN_IPV6(core->mac[MRQC]));
> +                                =
!!E1000_MRQC_EN_TCPIPV6(core->mac[MRQC]),
> +                                =
!!E1000_MRQC_EN_IPV6EX(core->mac[MRQC]),
> +                                =
!!E1000_MRQC_EN_IPV6(core->mac[MRQC]));
>=20
>         if ((!ex_dis || !ip6info->has_ext_hdrs) &&
>             (!new_ex_dis || !(ip6info->rss_ex_dst_valid ||
> diff --git a/hw/net/trace-events b/hw/net/trace-events
> index c714805..317fad4 100644
> --- a/hw/net/trace-events
> +++ b/hw/net/trace-events
> @@ -2,23 +2,23 @@
>=20
> # hw/net/lance.c
> lance_mem_readw(uint64_t addr, uint32_t ret) =
"addr=3D%"PRIx64"val=3D0x%04x"
> -lance_mem_writew(uint64_t addr, uint32_t val) =
"addr=3D%"PRIx64"val=3D0x%04x"
> +lance_mem_writew(uint64_t addr, uint64_t val) =
"addr=3D%"PRIx64"val=3D0x%04" PRIx64
>=20
> # hw/net/milkymist-minimac2.c
> -milkymist_minimac2_memory_read(uint32_t addr, uint32_t value) "addr =
%08x value %08x"
> -milkymist_minimac2_memory_write(uint32_t addr, uint32_t value) "addr =
%08x value %08x"
> +milkymist_minimac2_memory_read(hwaddr addr, uint32_t value) "addr =
%08" HWADDR_PRIx " value %08x"
> +milkymist_minimac2_memory_write(hwaddr addr, uint64_t value) "addr =
%08" HWADDR_PRIx " value %08" PRIx64
> milkymist_minimac2_mdio_write(uint8_t phy_addr, uint8_t addr, uint16_t =
value) "phy_addr %02x addr %02x value %04x"
> milkymist_minimac2_mdio_read(uint8_t phy_addr, uint8_t addr, uint16_t =
value) "phy_addr %02x addr %02x value %04x"
> milkymist_minimac2_tx_frame(uint32_t length) "length %u"
> -milkymist_minimac2_rx_frame(const void *buf, uint32_t length) "buf %p =
length %u"
> -milkymist_minimac2_rx_transfer(const void *buf, uint32_t length) "buf =
%p length %d"
> +milkymist_minimac2_rx_frame(const void *buf, size_t length) "buf %p =
length %zu"
> +milkymist_minimac2_rx_transfer(const void *buf, size_t length) "buf =
%p length %zd"
> milkymist_minimac2_raise_irq_rx(void) "Raise IRQ RX"
> milkymist_minimac2_lower_irq_rx(void) "Lower IRQ RX"
> milkymist_minimac2_pulse_irq_tx(void) "Pulse IRQ TX"
>=20
> # hw/net/mipsnet.c
> mipsnet_send(uint32_t size) "sending len=3D%u"
> -mipsnet_receive(uint32_t size) "receiving len=3D%u"
> +mipsnet_receive(size_t size) "receiving len=3D%zu"
> mipsnet_read(uint64_t addr, uint32_t val) "read addr=3D0x%" PRIx64 " =
val=3D0x%x"
> mipsnet_write(uint64_t addr, uint64_t val) "write addr=3D0x%" PRIx64 " =
val=3D0x%" PRIx64
> mipsnet_irq(uint32_t isr, uint32_t intctl) "set irq to %d (%02x)"
> @@ -41,7 +41,7 @@ open_eth_desc_write(uint32_t addr, uint32_t v) =
"DESC[%04x] <- %08x"
> pcnet_s_reset(void *s) "s=3D%p"
> pcnet_user_int(void *s) "s=3D%p"
> pcnet_isr_change(void *s, uint32_t isr, uint32_t isr_old) "s=3D%p =
INTA=3D%d<=3D%d"
> -pcnet_init(void *s, uint64_t init_addr) "s=3D%p init_addr=3D%#"PRIx64
> +pcnet_init(void *s, uint32_t init_addr) "s=3D%p init_addr=3D%#"PRIx32
> pcnet_rlen_tlen(void *s, uint32_t rlen, uint32_t tlen) "s=3D%p rlen=3D%d=
 tlen=3D%d"
> pcnet_ss32_rdra_tdra(void *s, uint32_t ss32, uint32_t rdra, uint32_t =
rcvrl, uint32_t tdra, uint32_t xmtrl) "s=3D%p ss32=3D%d rdra=3D0x%08x[%d] =
tdra=3D0x%08x[%d]"
>=20
> @@ -79,7 +79,7 @@ net_rx_pkt_l4_csum_fix_udp(uint32_t l4_cso) "UDP =
packet, L4 cso: %u"
> net_rx_pkt_l4_csum_fix_not_xxp(void) "Not an IP4 packet"
> net_rx_pkt_l4_csum_fix_ip4_fragment(void) "IP4 fragment"
> net_rx_pkt_l4_csum_fix_udp_with_no_checksum(void) "UDP packet without =
checksum"
> -net_rx_pkt_l4_csum_fix_csum(uint32_t cso, uint16_t csum) "L4 =
Checksum: Offset: %u, value 0x%X"
> +net_rx_pkt_l4_csum_fix_csum(size_t cso, uint16_t csum) "L4 Checksum: =
Offset: %zu, value 0x%X"
>=20
> net_rx_pkt_l3_csum_validate_entry(void) "Starting L3 checksum =
validation"
> net_rx_pkt_l3_csum_validate_not_ip4(void) "Not an IP4 packet"
> @@ -107,13 +107,13 @@ e1000x_link_negotiation_start(void) "Start link =
auto negotiation"
> e1000x_link_negotiation_done(void) "Auto negotiation is completed"
>=20
> # hw/net/e1000e_core.c
> -e1000e_core_write(uint64_t index, uint32_t size, uint64_t val) "Write =
to register 0x%"PRIx64", %d byte(s), value: 0x%"PRIx64
> -e1000e_core_read(uint64_t index, uint32_t size, uint64_t val) "Read =
from register 0x%"PRIx64", %d byte(s), value: 0x%"PRIx64
> +e1000e_core_write(int index, unsigned size, uint64_t val) "Write to =
register 0x%x, %d byte(s), value: 0x%"PRIx64
> +e1000e_core_read(int index, unsigned size, uint64_t val) "Read from =
register 0x%x, %d byte(s), value: 0x%"PRIx64
> e1000e_core_mdic_read(uint8_t page, uint32_t addr, uint32_t data) =
"MDIC READ: PHY[%u][%u] =3D 0x%x"
> e1000e_core_mdic_read_unhandled(uint8_t page, uint32_t addr) "MDIC =
READ: PHY[%u][%u] UNHANDLED"
> e1000e_core_mdic_write(uint8_t page, uint32_t addr, uint32_t data) =
"MDIC WRITE: PHY[%u][%u] =3D 0x%x"
> e1000e_core_mdic_write_unhandled(uint8_t page, uint32_t addr) "MDIC =
WRITE: PHY[%u][%u] UNHANDLED"
> -e1000e_core_ctrl_write(uint64_t index, uint32_t val) "Write CTRL =
register 0x%"PRIx64", value: 0x%X"
> +e1000e_core_ctrl_write(int index, uint32_t val) "Write CTRL register =
0x%x, value: 0x%X"
> e1000e_core_ctrl_sw_reset(void) "Doing SW reset"
> e1000e_core_ctrl_phy_reset(void) "Doing PHY reset"
>=20
> @@ -124,9 +124,9 @@ e1000e_link_set_ext_params(bool asd_check, bool =
speed_select_bypass) "Set extend
> e1000e_link_status(bool link_up, bool full_dplx, uint32_t speed, =
uint32_t asdv) "Link up: %d, Duplex: %d, Speed: %d, ASDV: %d"
> e1000e_link_status_changed(bool status) "New link status: %d"
>=20
> -e1000e_wrn_regs_write_ro(uint64_t index, uint32_t size, uint64_t val) =
"WARNING: Write to RO register 0x%"PRIx64", %d byte(s), value: =
0x%"PRIx64
> -e1000e_wrn_regs_write_unknown(uint64_t index, uint32_t size, uint64_t =
val) "WARNING: Write to unknown register 0x%"PRIx64", %d byte(s), value: =
0x%"PRIx64
> -e1000e_wrn_regs_read_unknown(uint64_t index, uint32_t size) "WARNING: =
Read from unknown register 0x%"PRIx64", %d byte(s)"
> +e1000e_wrn_regs_write_ro(int index, unsigned size, uint64_t val) =
"WARNING: Write to RO register 0x%x, %d byte(s), value: 0x%"PRIx64
> +e1000e_wrn_regs_write_unknown(int index, unsigned size, uint64_t val) =
"WARNING: Write to unknown register 0x%x, %d byte(s), value: 0x%"PRIx64
> +e1000e_wrn_regs_read_unknown(int index, unsigned size) "WARNING: Read =
from unknown register 0x%x, %d byte(s)"
> e1000e_wrn_regs_read_trivial(uint32_t index) "WARNING: Reading =
register at offset: 0x%05x. It is not fully implemented."
> e1000e_wrn_regs_write_trivial(uint32_t index) "WARNING: Writing to =
register at offset: 0x%05x. It is not fully implemented."
> e1000e_wrn_no_ts_support(void) "WARNING: Guest requested TX =
timestamping which is not supported"
> @@ -166,10 +166,10 @@ e1000e_rx_start_recv(void)
>=20
> e1000e_rx_rss_started(void) "Starting RSS processing"
> e1000e_rx_rss_disabled(void) "RSS is disabled"
> -e1000e_rx_rss_type(uint32_t type) "RSS type is %u"
> -e1000e_rx_rss_ip4(bool isfragment, bool istcp, uint32_t mrqc, bool =
tcpipv4_enabled, bool ipv4_enabled) "RSS IPv4: fragment %d, tcp %d, mrqc =
0x%X, tcpipv4 enabled %d, ipv4 enabled %d"
> -e1000e_rx_rss_ip6_rfctl(uint32_t rfctl) "RSS IPv6: rfctl 0x%X"
> -e1000e_rx_rss_ip6(bool ex_dis, bool new_ex_dis, bool istcp, bool =
has_ext_headers, bool ex_dst_valid, bool ex_src_valid, uint32_t mrqc, =
bool tcpipv6_enabled, bool ipv6ex_enabled, bool ipv6_enabled) "RSS IPv6: =
ex_dis: %d, new_ex_dis: %d, tcp %d, has_ext_headers %d, ex_dst_valid %d, =
ex_src_valid %d, mrqc 0x%X, tcpipv6 enabled %d, ipv6ex enabled %d, ipv6 =
enabled %d"
> +e1000e_rx_rss_type(uint32_t type) "RSS type is %" PRIu32
> +e1000e_rx_rss_ip4(bool isfragment, bool istcp, uint32_t mrqc, bool =
tcpipv4_enabled, bool ipv4_enabled) "RSS IPv4: fragment %d, tcp %d, mrqc =
0x%" PRIX32 ", tcpipv4 enabled %d, ipv4 enabled %d"
> +e1000e_rx_rss_ip6_rfctl(uint32_t rfctl) "RSS IPv6: rfctl 0x%" PRIX32
> +e1000e_rx_rss_ip6(bool ex_dis, bool new_ex_dis, bool istcp, bool =
has_ext_headers, bool ex_dst_valid, bool ex_src_valid, uint32_t mrqc, =
bool tcpipv6_enabled, bool ipv6ex_enabled, bool ipv6_enabled) "RSS IPv6: =
ex_dis: %d, new_ex_dis: %d, tcp %d, has_ext_headers %d, ex_dst_valid %d, =
ex_src_valid %d, mrqc 0x%" PRIX32 ", tcpipv6 enabled %d, ipv6ex enabled =
%d, ipv6 enabled %d"
> e1000e_rx_rss_dispatched_to_queue(int queue_idx) "Packet being =
dispatched to queue %d"
>=20
> e1000e_rx_metadata_protocols(bool isip4, bool isip6, bool isudp, bool =
istcp) "protocols: ip4: %d, ip6: %d, udp: %d, tcp: %d"
> @@ -244,15 +244,15 @@ e1000e_cb_qdev_reset(void) "E1000E qdev reset =
entry"
> e1000e_cb_pre_save(void) "E1000E pre save entry"
> e1000e_cb_post_load(void) "E1000E post load entry"
>=20
> -e1000e_io_write_addr(uint64_t addr) "IOADDR write 0x%"PRIx64
> -e1000e_io_write_data(uint64_t addr, uint64_t val) "IODATA write =
0x%"PRIx64", value: 0x%"PRIx64
> -e1000e_io_read_addr(uint64_t addr) "IOADDR read 0x%"PRIx64
> -e1000e_io_read_data(uint64_t addr, uint64_t val) "IODATA read =
0x%"PRIx64", value: 0x%"PRIx64
> -e1000e_wrn_io_write_unknown(uint64_t addr) "IO write unknown address =
0x%"PRIx64
> -e1000e_wrn_io_read_unknown(uint64_t addr) "IO read unknown address =
0x%"PRIx64
> -e1000e_wrn_io_addr_undefined(uint64_t addr) "IO undefined register =
0x%"PRIx64
> -e1000e_wrn_io_addr_flash(uint64_t addr) "IO flash access =
(0x%"PRIx64") not implemented"
> -e1000e_wrn_io_addr_unknown(uint64_t addr) "IO unknown register =
0x%"PRIx64
> +e1000e_io_write_addr(hwaddr addr) "IOADDR write 0x%" HWADDR_PRIx
> +e1000e_io_write_data(uint32_t addr, uint64_t val) "IODATA write =
0x%"PRIx32", value: 0x%"PRIx64
> +e1000e_io_read_addr(uint32_t addr) "IOADDR read 0x%"PRIx32
> +e1000e_io_read_data(uint32_t addr, uint64_t val) "IODATA read =
0x%"PRIx32", value: 0x%"PRIx64
> +e1000e_wrn_io_write_unknown(hwaddr addr) "IO write unknown address =
0x%" HWADDR_PRIx
> +e1000e_wrn_io_read_unknown(hwaddr addr) "IO read unknown address 0x%" =
HWADDR_PRIx
> +e1000e_wrn_io_addr_undefined(uint32_t addr) "IO undefined register =
0x%"PRIx32
> +e1000e_wrn_io_addr_flash(uint32_t addr) "IO flash access =
(0x%"PRIx32") not implemented"
> +e1000e_wrn_io_addr_unknown(uint32_t addr) "IO unknown register =
0x%"PRIx32
>=20
> e1000e_msi_init_fail(int32_t res) "Failed to initialize MSI, error %d"
> e1000e_msix_init_fail(int32_t res) "Failed to initialize MSI-X, error =
%d"
> @@ -270,8 +270,8 @@ spapr_vlan_get_rx_bd_from_page_found(uint32_t =
use_buf_ptr, uint32_t rx_bufs) "pt
> spapr_vlan_receive(const char *id, uint32_t rx_bufs) "[%s] =
rx_bufs=3D%"PRIu32
> spapr_vlan_receive_dma_completed(void) "DMA write completed"
> spapr_vlan_receive_wrote(uint64_t ptr, uint64_t hi, uint64_t lo) "rxq =
entry (ptr=3D0x%"PRIx64"): 0x%016"PRIx64" 0x%016"PRIx64
> -spapr_vlan_add_rxbuf_to_pool_create(int pool, uint64_t len) "created =
RX pool %d for size %"PRIu64
> -spapr_vlan_add_rxbuf_to_pool(int pool, uint64_t len, int32_t count) =
"add buf using pool %d (size %"PRIu64", count=3D%"PRId32")"
> +spapr_vlan_add_rxbuf_to_pool_create(int pool, unsigned long long len) =
"created RX pool %d for size %llu"
> +spapr_vlan_add_rxbuf_to_pool(int pool, unsigned long long len, =
int32_t count) "add buf using pool %d (size %llu, count=3D%"PRId32")"
> spapr_vlan_add_rxbuf_to_page(uint32_t ptr, uint32_t rx_bufs, uint64_t =
bd) "added buf ptr=3D%"PRIu32"  rx_bufs=3D%"PRIu32" bd=3D0x%016"PRIx64
> spapr_vlan_h_add_logical_lan_buffer(uint64_t reg, uint64_t buf) =
"H_ADD_LOGICAL_LAN_BUFFER(0x%"PRIx64", 0x%"PRIx64")"
> spapr_vlan_h_send_logical_lan(uint64_t reg, uint64_t continue_token) =
"H_SEND_LOGICAL_LAN(0x%"PRIx64", <bufs>, 0x%"PRIx64")"
> --=20
> 2.9.3
>=20
