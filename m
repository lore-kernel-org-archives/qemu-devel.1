Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DA7C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:49:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 921AD2071A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="lRXmMa3O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 921AD2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnNkx-0000cK-RT
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 10:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jnNiU-0003Ij-Gz; Mon, 22 Jun 2020 10:46:35 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:43124)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jnNiS-0007rI-1v; Mon, 22 Jun 2020 10:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=MCDsdn9l/8SiTeZRPDjBzDQ7YykFf/5v/rkXmycZU/g=; 
 b=lRXmMa3OYnawqxd0UvElkGvLIpLtAx855NsSxXYJiiIy6EMmi6Ks1GN+UefexnQKyDheZxMG2nOb3lvAhbpu4xi25A+pWLeunnnqcj3oAA5++4HSGn6XDP+0LiGHlMQBpAphIzVkbA99n0Bd3X0uJlP75vJGe+KzEVWO2E1HGzPT9MCW3XwhvazLg5HhA5yLTh+z7lcXIJ6/kFSnpR4xVEG5gf9xooQhno+ud9Jox0/gFML1z/bbybWJMMli+sP36OuIs1d9ypbBwikFCo4B5mVXbCcW9yMzvpE+Ep97GkLne5ktvs+k5/CcG2h48Zf5fm/e3iSichaWlDz3ekYZ0A==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jnNi4-00030B-5r; Mon, 22 Jun 2020 16:46:08 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jnNi3-0003YZ-ST; Mon, 22 Jun 2020 16:46:07 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH 1/2] qcow2: Force preallocation with data-file-raw
In-Reply-To: <9c14c622-eb30-4619-d33a-b59395a397be@redhat.com>
References: <20200619104012.235977-1-mreitz@redhat.com>
 <20200619104012.235977-2-mreitz@redhat.com>
 <w51eeqb9f43.fsf@maestria.local.igalia.com>
 <9c14c622-eb30-4619-d33a-b59395a397be@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Mon, 22 Jun 2020 16:46:07 +0200
Message-ID: <w51r1u788gg.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 10:46:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon 22 Jun 2020 11:35:59 AM CEST, Max Reitz wrote:
>>> +    if (qcow2_opts->data_file_raw &&
>>> +        qcow2_opts->preallocation =3D=3D PREALLOC_MODE_OFF)
>>> +    {
>>> +        /*
>>> +         * data-file-raw means that "the external data file can be
>>> +         * read as a consistent standalone raw image without looking
>>> +         * at the qcow2 metadata."  It does not say that the metadata
>>> +         * must be ignored, though (and the qcow2 driver in fact does
>>> +         * not ignore it), so the L1/L2 tables must be present and
>>> +         * give a 1:1 mapping, so you get the same result regardless
>>> +         * of whether you look at the metadata or whether you ignore
>>> +         * it.
>>> +         */
>>> +        qcow2_opts->preallocation =3D PREALLOC_MODE_METADATA;
>>=20
>> I'm not convinced by this,
>
> Why not?
>
> This is how I read the spec.  Furthermore, I see two problems that we
> have right now that are fixed by this patch (namely (1) using a device
> file as the external data file, which may have non-zero data at
> creation; and (2) assigning a backing file at runtime must not show
> the data).

What happens if you first create the image (which would be preallocated
with this patch), then you resize it and finally you assign the backing
file? Would the resized part be preallocated?

>> but your comment made me think of another possible alternative: in
>> qcow2_get_cluster_offset(), if the cluster is unallocated and we are
>> using a raw data file then we return _ZERO_PLAIN:
>>=20
>> --- a/block/qcow2-cluster.c
>> +++ b/block/qcow2-cluster.c
>> @@ -654,6 +654,10 @@ out:
>>      assert(bytes_available - offset_in_cluster <=3D UINT_MAX);
>>      *bytes =3D bytes_available - offset_in_cluster;
>>=20=20
>> +    if (type =3D=3D QCOW2_CLUSTER_UNALLOCATED && data_file_is_raw(bs)) {
>> +        type =3D QCOW2_CLUSTER_ZERO_PLAIN;
>> +    }
>> +
>>      return type;
>>=20
>> You could even add a '&& bs->backing' to the condition and emit a
>> warning to make it more explicit.
>
> No, this is wrong.  This still wouldn=E2=80=99t fix the problem of having=
 a
> device file as the external data file, when it already has non-zero
> data during creation.  (Reading the qcow2 file would return zeroes,
> but reading the device would not.)

But you wouldn't fix that preallocating the metadata either, you would
need to fill the device with zeroes.

> I interpret the spec in that the metadata can be ignored, but it does
> not need to be ignored.  So the L1/L2 tables must be 1:1 mapping of
> QCOW2_CLUSTER_NORMAL entries.
>
> We could also choose to interpret it as =E2=80=9CWith data-file-raw, the =
L1/L2
> tables must be ignored=E2=80=9D.  In that case, our qcow2 driver would ne=
ed to
> be modified to indeed fully ignore the L1/L2 tables with
> data-file-raw.  (I certainly don=E2=80=99t interpret the spec this way, b=
ut I
> suppose we could call it a bug fix and amend it.)

The way I interpret it is that regardless of whether you read the data
through the qcow2 file or directly from the data file you should get the
same results, but how that should be reflected in the L1/L2 metadata is
not specified.

Berto

