Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACBEC2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 12:44:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FB1120769
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 12:44:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB1120769
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMt1j-0002gm-Mk
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 08:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1jMt0n-0001Zu-2I
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 08:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1jMt0l-0000MX-PO
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 08:43:56 -0400
Received: from [192.146.155.5] (port=62389 helo=mcp02.nutanix.com)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1jMt0l-0000MH-Fd
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 08:43:55 -0400
Received: from localhost.localdomain (unknown [10.22.39.231])
 by mcp02.nutanix.com (Postfix) with ESMTP id BE62A10061FA;
 Fri, 10 Apr 2020 12:35:51 +0000 (UTC)
Date: Thu, 9 Apr 2020 20:21:16 -0400
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: Stefan Hajnoczi <stefanha@gmail.com>, dgilbert@redhat.com
Subject: Re: [Qemu-devel] Should memory hotplug work with vhost-user backends?
Message-ID: <20200410002116.GA7478@localhost.localdomain>
References: <6EF9E5BE-2FBF-4CC4-BA1F-AE55ADD82A6E@nutanix.com>
 <20190703100431.GA17523@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190703100431.GA17523@stefanha-x1.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 192.146.155.5
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 03, 2019 at 11:04:31AM +0100, Stefan Hajnoczi wrote:
> On Tue, Jul 02, 2019 at 10:08:54PM +0000, Raphael Norwitz wrote:
> > For background I am trying to work around a ram slot limit imposed by=
 the vhost-user protocol. We are having trouble reconciling the comment h=
ere: https://github.com/qemu/qemu/blob/master/hw/virtio/vhost-user.c#L333=
  that =E2=80=9CFor non-vring specific requests, like VHOST_USER_SET_MEM_=
TABLE., we just need to send it once the first time=E2=80=9D and the high=
 level implementation of memory hot-add, which calls set_mem_table every =
time a VM hot adds memory.
> >=20
> > A few questions:
> > 1.
> > What exactly is the check `if (vhost_user_one_time_request(msg->hdr.r=
equest) && dev->vq_index !=3D 0)` for? In the message for commit b931bfbf=
042983f311b3b09894d8030b2755a638, which introduced the check, I see it sa=
ys =E2=80=9Cnon-vring specific messages[, which should] be sent only once=
=E2=80=9D and gives VHOST_USER_SET_MEM_TABLE as an example one such messa=
ge. The `vhost_user_one_time_request()` call clearly checks whether this =
type of message is the kind of message is supposed to be sent once of whi=
ch VHOST_USER_SET_MEM_TABLE is one. Why, then, does this commit add the c=
heck if `dev->vq_index !=3D 0`? It seems like there is a latent assumptio=
n that after the first call dev->vq_index should be set to some value gre=
ater than one, however for many cases such as vhost-user-scsi devices we =
can see this is clearly not the case https://github.com/qemu/qemu/blob/ma=
ster/hw/scsi/vhost-user-scsi.c#L95. Is this check then =E2=80=98broken=E2=
=80=99 for such devices?
> >=20
> > 2.
> > If this check is indeed broken for such devices, and set_mem_table ca=
ll is only supposed to be run once for such devices, is the ability to ca=
ll it multiple times technically a bug for devices such as vhost-user-scs=
ci devices? If so, this would imply that the existing ability to hot add =
memory to vhost-user-scsi devices is by extension technically a bug/unint=
ended behavior. Is this the case?
>=20
> Hi Raphael,
> David Gilbert and I recently came to the conclusion that memory hotplug
> is not safe in vhost-user device backends built using libvhost-user.

Hi David, Sefan,

Just want to follow up here. Sorry - I know this was a while ago.

I am looking to add postcopy migration support for my patch set lifting
the vhost-user max ram slots limitation
(https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg06641.html)
and it seems the most convienient way to do this would be to add support
for my new protocol feature in libvhost-user and then test with
vhost-user-bridge.

I've briefly looked through the libvhost-user code and the hot-add path
looks safe enough to me (or at least no more broken than the regular
vhost-user memory hot-add path).

Can you elaborate a little more about why memory hot-add is unsafe with
vhost-user device backends built with libvhost-user, as opposed to those
using the raw vhost-user protocol semantics?


Thanks,
Raphael

>=20
> It's likely that memory hotplug hasn't been fully thought through at th=
e
> protocol specification and QEMU vhost-user master implementation levels
> either.
>=20
> We didn't investigate deeper for the time being, but I'm not surprised
> that you've found inconsistencies.  The ability to hotplug memory is a
> valuable feature.  It will be necessary to get it working sooner or
> later.
>=20
> Are you going to work on it?
>=20
> Stefan



