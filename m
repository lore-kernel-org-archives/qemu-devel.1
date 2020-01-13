Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF34BC33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 19:44:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A98B121556
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 19:44:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98B121556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir5dA-0008Fs-MS
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 14:44:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1ir5cK-0007AB-CE
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 14:43:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1ir5cI-00077B-H6
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 14:43:15 -0500
Received: from [192.146.154.1] (port=45159 helo=mcp01.nutanix.com)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1ir5cI-00075u-8g
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 14:43:14 -0500
Received: from raphael-norwitz.user.nutanix.com
 (raphael-norwitz.dev.nutanix.com [10.41.25.241])
 by mcp01.nutanix.com (Postfix) with ESMTP id 11725100693B;
 Mon, 13 Jan 2020 19:43:13 +0000 (UTC)
Date: Mon, 13 Jan 2020 11:43:13 -0800
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: mst@redhat.com, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 0/3] vhost-user: Lift Max Ram Slots Limitation
Message-ID: <20200113194313.GA73843@raphael-norwitz.user.nutanix.com>
References: <1575874847-5792-1-git-send-email-raphael.norwitz@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1575874847-5792-1-git-send-email-raphael.norwitz@nutanix.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 192.146.154.1
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping

On Mon, Dec 09, 2019 at 02:00:44AM -0500, Raphael Norwitz wrote:
>=20
> In QEMU today, a VM with a vhost-user device can hot add memory a
> maximum of 8 times. See these threads, among others:
>=20
> [1] https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg01046.html=
 =20
>     https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg01236.html=
=20
>=20
> [2] https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg04656.html=
=20
>=20
> This RFC/patch set introduces a new protocol feature
> VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS which, when enabled, lifts the
> restriction on the maximum number RAM slots imposed by vhost-user.
>=20
> The patch consists of 3 changes:
> 1. Fixed Error Handling in vhost_user_set_mem_table_postcopy:
>    This is a bug fix in the postcopy migration path
> 2. vhost-user: Refactor vhost_user_set_mem_table Functions:
>    This is a non-functional change refractoring the
>    vhost_user_set_mem_table and vhost_user_set_mem_table_postcopy
>    functions such that the feature can be more cleanly added.
> 3. Introduce Configurable Number of Memory Slots Exposed by vhost-user:
>    This change introduces the new protocol feature
>    VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS.
>=20
> The implementation details are explained in more detail in the commit
> messages, but at a high level the new protocol feature works as follows=
:
> - If the VHOST_USER_PROTCOL_F_CONFIGURE_SLOTS feature is enabled, QEMU =
will
>   send multiple VHOST_USER_ADD_MEM_REG and VHOST_USER_REM_MEM_REG
>   messages to map and unmap individual memory regions instead of one la=
rge
>   VHOST_USER_SET_MEM_TABLE message containing all memory regions.
> - The vhost-user struct maintains a =E2=80=99shadow state=E2=80=99 of m=
emory regions
>   already sent to the guest. Each time vhost_user_set_mem_table is call=
ed,
>   the shadow state is compared with the new device state. A
>   VHOST_USER_REM_MEM_REG will be sent for each region in the shadow sta=
te
>   not in the device state. Then, a VHOST_USER_ADD_MEM_REG will be sent
>   for each region in the device state but not the shadow state. After
>   these messages have been sent, the shadow state will be updated to
>   reflect the new device state.
>=20
> The VHOST_USER_SET_MEM_TABLE message was not reused because as the numb=
er of
> regions grows, the message becomes very large. In practice, such large
> messages caused problems (truncated messages) and in the past it seems =
the
> community has opted for smaller fixed size messages where possible. VRI=
NGs,
> for example, are sent to the backend individually instead of in one mas=
sive
> message.
>=20
> Current Limitations:
> - postcopy migration is not supported when the
>   VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS has been negotiated.=20
> - VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS cannot be negotiated when
>   VHOST_USER_PROTOCOL_F_REPLY_ACK has also been negotiated.
>=20
> Both of these limitations are due to resource contraints. They are not
> imposed for technical reasons.
>=20
> Questions:
> - In the event transmitting a VHOST_USER_ADD_MEM_REG or
>   VHOST_USER_REM_REG message fails, is there any reason the error handl=
ing
>   should differ from when transmitting VHOST_USER_SET_MEM_TABLE message=
 fails?
> - Is there a cleaner way to ensure to ensure a postcopy migration canno=
t be
>   started with this protocol feature enabled?
>=20
> Best,
> Raphael
>=20
> Raphael Norwitz (3):
>   Fixed Error Handling in vhost_user_set_mem_table_postcopy
>   vhost-user: Refactor vhost_user_set_mem_table Functions
>   Introduce Configurable Number of Memory Slots Exposed by vhost-user:
>=20
>  docs/interop/vhost-user.rst |  43 +++++
>  hw/virtio/vhost-user.c      | 384 +++++++++++++++++++++++++++++++++---=
--------
>  2 files changed, 335 insertions(+), 92 deletions(-)
>=20
> --=20
> 1.8.3.1
>=20
>=20

