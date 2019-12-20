Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC6EC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:32:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46DFC21655
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="mLPL3T8R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46DFC21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiHSI-0006R0-DR
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 07:32:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33562)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iiHRT-0005Ze-HC
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:31:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iiHRS-0003bh-5y
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:31:39 -0500
Received: from kylie.crudebyte.com ([5.189.157.229]:34209)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1iiHRR-0003WD-LJ
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:31:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=bQpsLq7J3RYMHBoq5fRSkyITpwUgyfSZoxe75G2PCy4=; b=mLPL3T8RcCMGa+mMs3ezSCLu4T
 i3fzfvCVGSWMiWJhxapW7MUGg7g+qRDEvqWbCeV7X0h3oGhgRJ5qLGcOUoXg+aRZf30YMZHasacFN
 yaYbmKKi8NWDmaZBkujrAPI1JszEumThEd+lapW6CXq9MmVPj7oAPMeaZw44zx3q5LLNNg2TPdZEd
 EYhRh57l3IuweTV+ppvh3mAzMM7YYNV4pI4l/ENzFoLfs9eVvdaherU/d7S0nC3eWSK3hIb28mfTR
 Zl41iTG5aiFim3QOKdOG0o1UmfYcuhpwEzQBpE8gosWxSnU06kpZN9Gcry5uE7jK8bMxpk2SoVLKO
 VBEpY50nTVTXWWwQ+aGKShrrnAZTxAWSvgJvMarNqY/4UwhtDvki++0OzEsZ0piOYtNdT+NJfDhYu
 P+0+tc2fsfbNXqJkMhigyphVhOaNwNKFIwe+N9Ow8IZnrQXt1sUqBGL7A+ZX42duAyEyCo4gCxaf/
 AarnXSHTcjp5v5aB1enz7TtbkGCQYcCa13etdbBkpnDLlN6EwmPcFUzNLvmSl0P5UDXQMM4UT8KPp
 9+jT/D/Wa0hTCiG53R3cq7Pjbj20CoG/YTBdw07b36PT6MEE5OWu5Kce+Brg4lttgAfbEi2KISEgt
 TpsSuL1bt6hc7DK9KkNq2eHr/hammLzBp3C9VERYU=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, anthony.perard@citrix.com,
 Greg Kurz <groug@kaod.org>, Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: Re: [PATCH] 9p: init_in_iov_from_pdu can truncate the size
Date: Fri, 20 Dec 2019 13:31:29 +0100
Message-ID: <60649649.mbVaKIiDdU@silver>
In-Reply-To: <alpine.DEB.2.21.1912191434260.9832@sstabellini-ThinkPad-T480s>
References: <20191219004251.23763-1-sstabellini@kernel.org>
 <2734053.qHGH40kZ6z@silver>
 <alpine.DEB.2.21.1912191434260.9832@sstabellini-ThinkPad-T480s>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.189.157.229
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

On Donnerstag, 19. Dezember 2019 23:36:07 CET Stefano Stabellini wrote:
> On Thu, 19 Dec 2019, Christian Schoenebeck wrote:
> > On Donnerstag, 19. Dezember 2019 01:42:51 CET Stefano Stabellini wrote:
> > > From: Stefano Stabellini <stefano.stabellini@xilinx.com>
> > > 
> > > init_in_iov_from_pdu might not be able to allocate the full buffer size
> > > requested, which comes from the client and could be larger than the
> > > transport has available at the time of the request. Specifically, this
> > > can happen with read operations, with the client requesting a read up to
> > > the max allowed, which might be more than the transport has available at
> > > the time.
> > 
> > I haven't looked thoroughly at this yet, but that's about addressing a
> > temporary, not a permanent transport buffer size limitation, right?
> 
> Yes, that is correct.

One more thing ...

> diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> index 775e8ff766..68873c3f5f 100644
> --- a/hw/9pfs/virtio-9p-device.c
> +++ b/hw/9pfs/virtio-9p-device.c
> @@ -145,19 +145,15 @@ static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu,
> size_t offset, }
> 
>  static void virtio_init_in_iov_from_pdu(V9fsPDU *pdu, struct iovec **piov,
> -                                        unsigned int *pniov, size_t size)
> +                                        unsigned int *pniov, size_t *size)
>  {
>      V9fsState *s = pdu->s;
>      V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
>      VirtQueueElement *elem = v->elems[pdu->idx];
>      size_t buf_size = iov_size(elem->in_sg, elem->in_num);
> 
> -    if (buf_size < size) {
> -        VirtIODevice *vdev = VIRTIO_DEVICE(v);
> -
> -        virtio_error(vdev,
> -                     "VirtFS reply type %d needs %zu bytes, buffer has
> %zu", -                     pdu->id + 1, size, buf_size);
> +    if (buf_size < *size) {
> +        *size = buf_size;
>      }
> 
>      *piov = elem->in_sg;

Here could be a problem: what happens if the currently available transport 
buffer size is extremely small, i.e. less than P9_IOHDRSZ? I am not sure that 
would be handled safely everywhere. So maybe it would make sense to make 
transport buffer size < P9_IOHDRSZ an error case here?

Best regards,
Christian Schoenebeck



