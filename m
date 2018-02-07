Received: from eggs.gnu.org ([2001:4830:134:3::10]:48907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejOOp-0005D7-Eb
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:00:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejOOg-0000i4-3k
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:00:27 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ejOOf-0000ht-T4
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:00:18 -0500
Received: by mail-wm0-f65.google.com with SMTP id g1so2655591wmg.2
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 04:00:17 -0800 (PST)
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
	<20180206203048.11096-30-rkagan@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b9ee4d69-130e-74bc-42f7-0ab372d0070b@redhat.com>
Date: Wed, 7 Feb 2018 13:00:14 +0100
MIME-Version: 1.0
In-Reply-To: <20180206203048.11096-30-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 29/34] net: add Hyper-V/VMBus network
 protocol definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Ben Warren <ben@skyportsystems.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Vadim Rozenfeld <vrozenfe@redhat.com>, "Denis V. Lunev" <den@openvz.org>, si-wei liu <si-wei.liu@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>

On 06/02/2018 21:30, Roman Kagan wrote:
> +/* NdisInitialize message */
> +struct rndis_initialize_request {
> +    uint32_t req_id;
> +    uint32_t major_ver;
> +    uint32_t minor_ver;
> +    uint32_t max_xfer_size;
> +};
> +
> +/* Response to NdisInitialize */
> +struct rndis_initialize_complete {
> +    uint32_t req_id;
> +    uint32_t status;
> +    uint32_t major_ver;
> +    uint32_t minor_ver;
> +    uint32_t dev_flags;
> +    uint32_t medium;
> +    uint32_t max_pkt_per_msg;
> +    uint32_t max_xfer_size;
> +    uint32_t pkt_alignment_factor;
> +    uint32_t af_list_offset;
> +    uint32_t af_list_size;
> +};
> +
> +/* Call manager devices only: Information about an address family */
> +/* supported by the device is appended to the response to NdisInitialize. */
> +struct rndis_co_address_family {
> +    uint32_t address_family;
> +    uint32_t major_ver;
> +    uint32_t minor_ver;
> +};
> +
> +/* NdisHalt message */
> +struct rndis_halt_request {
> +    uint32_t req_id;
> +};
> +
> +/* NdisQueryRequest message */
> +struct rndis_query_request {
> +    uint32_t req_id;
> +    uint32_t oid;
> +    uint32_t info_buflen;
> +    uint32_t info_buf_offset;
> +    uint32_t dev_vc_handle;
> +};
> +
> +/* Response to NdisQueryRequest */
> +struct rndis_query_complete {
> +    uint32_t req_id;
> +    uint32_t status;
> +    uint32_t info_buflen;
> +    uint32_t info_buf_offset;
> +};
> +
> +/* NdisSetRequest message */
> +struct rndis_set_request {
> +    uint32_t req_id;
> +    uint32_t oid;
> +    uint32_t info_buflen;
> +    uint32_t info_buf_offset;
> +    uint32_t dev_vc_handle;
> +};
> +
> +/* Response to NdisSetRequest */
> +struct rndis_set_complete {
> +    uint32_t req_id;
> +    uint32_t status;
> +};
> +
> +/* NdisReset message */
> +struct rndis_reset_request {
> +    uint32_t reserved;
> +};
> +
> +/* Response to NdisReset */
> +struct rndis_reset_complete {
> +    uint32_t status;
> +    uint32_t addressing_reset;
> +};
> +
> +/* NdisMIndicateStatus message */
> +struct rndis_indicate_status {
> +    uint32_t status;
> +    uint32_t status_buflen;
> +    uint32_t status_buf_offset;
> +};
> +
> +/* Diagnostic information passed as the status buffer in */
> +/* struct rndis_indicate_status messages signifying error conditions. */
> +struct rndis_diagnostic_info {
> +    uint32_t diag_status;
> +    uint32_t error_offset;
> +};
> +
> +/* NdisKeepAlive message */
> +struct rndis_keepalive_request {
> +    uint32_t req_id;
> +};
> +
> +/* Response to NdisKeepAlive */
> +struct rndis_keepalive_complete {
> +    uint32_t req_id;
> +    uint32_t status;
> +};
> +

Hmm, these are a bit harder to unify with hw/usb/dev-network.c.  Still
not _that_ hard, just that the USB version has two fields for message
type/length at the beginning.  Probably worth it even if we keep two
versions of the core RNDIS code.

Paolo
