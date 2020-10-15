Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F1DC43457
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:10:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9516721D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OtRyaYnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9516721D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT5pi-0002x9-5V
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 12:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kT5kS-0005VC-AC
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:05:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kT5kO-0003Pi-3x
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602777894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pEXm3bO6yAg0BeP2coE8pmFugBB9PfCuJQ+xF3h7n20=;
 b=OtRyaYnBAeK9akplRFPR6IdsGWBkSR1XxGIvIKdTM7k5ATYOU8DHg5S34pICepF8dXRd/Y
 OAM5mDdmPCmrqUbaTWDZ6N4bHpqYQbs/W59mmwlX0vxBbkOdz0rWbmUfwJiP/ij2MeTbWt
 6o/nQYoHjDJdPA2V8O77kruT9SvDAUE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-vilMZYjIP2-DU_sWxSO2AQ-1; Thu, 15 Oct 2020 12:04:44 -0400
X-MC-Unique: vilMZYjIP2-DU_sWxSO2AQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A6A918CBC42;
 Thu, 15 Oct 2020 16:04:43 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.194.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EE12360CD0;
 Thu, 15 Oct 2020 16:04:38 +0000 (UTC)
Subject: Re: [PATCH v2 03/20] fuse: Implement standard FUSE operations
To: Kevin Wolf <kwolf@redhat.com>
References: <20200922104932.46384-1-mreitz@redhat.com>
 <20200922104932.46384-4-mreitz@redhat.com>
 <20201015094622.GC4610@merkur.fritz.box>
 <34828933-5ac1-ba04-39e8-eeaef604f5b0@redhat.com>
 <20201015155800.GL4610@merkur.fritz.box>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <1768b35f-8615-1f0f-b008-6628882c6eaa@redhat.com>
Date: Thu, 15 Oct 2020 18:04:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201015155800.GL4610@merkur.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Uk7pNtTh3cgxe7wooyWqadOyQ5O9sqC5u"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Uk7pNtTh3cgxe7wooyWqadOyQ5O9sqC5u
Content-Type: multipart/mixed; boundary="eNoBbsi6lxCJY4sPaOdYQDhrBV7pZGv2W"

--eNoBbsi6lxCJY4sPaOdYQDhrBV7pZGv2W
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.10.20 17:58, Kevin Wolf wrote:
> Am 15.10.2020 um 17:18 hat Max Reitz geschrieben:
>> On 15.10.20 11:46, Kevin Wolf wrote:
>>> Am 22.09.2020 um 12:49 hat Max Reitz geschrieben:
>>>> This makes the export actually useful instead of only producing errors
>>>> whenever it is accessed.
>>>>
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
>>>> +/**
>>>> + * Handle client reads from the exported image.
>>>> + */
>>>> +static void fuse_read(fuse_req_t req, fuse_ino_t inode,
>>>> +                      size_t size, off_t offset, struct fuse_file_inf=
o *fi)
>>>> +{
>>>> +    FuseExport *exp =3D fuse_req_userdata(req);
>>>> +    int64_t length;
>>>> +    void *buf;
>>>> +    int ret;
>>>> +
>>>> +    /**
>>>> +     * Clients will expect short reads at EOF, so we have to limit
>>>> +     * offset+size to the image length.
>>>> +     */
>>>> +    length =3D blk_getlength(exp->common.blk);
>>>> +    if (length < 0) {
>>>> +        fuse_reply_err(req, -length);
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    size =3D MIN(size, FUSE_MAX_BOUNCE_BYTES);
>>>
>>> "Read should send exactly the number of bytes requested except on EOF o=
r
>>> error, otherwise the rest of the data will be substituted with zeroes."
>>
>> :(
>>
>>> Do we corrupt huge reads with this, so that read() succeeds, but the
>>> buffer is zeroed above 64M instead of containing the correct data? Mayb=
e
>>> we should return an error instead?
>>
>> Hm.  It looks like there is a max_read option obeyed by the kernel
>> driver, and it appears it=E2=80=99s set by implementing .init() and sett=
ing
>> fuse_conn_info.max_read (also, =E2=80=9Cfor the time being=E2=80=9D it h=
as to also set
>> in the mount options passed to fuse_session_new()).
>>
>> I=E2=80=99m not sure whether that does anything, though.  It appears tha=
t
>> whenever I do a cached read, it caps out at 128k (which is what
>> cuse_prep_data() in libfuse sets; though increasing that number there
>> doesn=E2=80=99t change anything, so I think that=E2=80=99s just a coinci=
dence), and with
>> O_DIRECT, it caps out at 1M.
>>
>> But at least that would be grounds to return an error for >64M requests.
>>  (Limiting max_read to 64k does limit all read requests to 64k.)
>=20
> Yes, setting max_read and making larger requests an error seems like a
> good solution.
>=20
>> Further investigation is needed.
>=20
> If you want :-)

Not really, but 128k per request is a bit sad.

[...]

>>>> +/**
>>>> + * Let clients flush the exported image.
>>>> + */
>>>> +static void fuse_flush(fuse_req_t req, fuse_ino_t inode,
>>>> +                       struct fuse_file_info *fi)
>>>> +{
>>>> +    FuseExport *exp =3D fuse_req_userdata(req);
>>>> +    int ret;
>>>> +
>>>> +    ret =3D blk_flush(exp->common.blk);
>>>> +    fuse_reply_err(req, ret < 0 ? -ret : 0);
>>>> +}
>>>
>>> This seems to be an implementation for .fsync rather than for .flush.
>>
>> Wouldn=E2=80=99t fsync entail a drain?
>=20
> Hm, the libfuse documentation doesn't say anything about draining. I
> suppose this is because if requests need to be drained, it will do so in
> the kernel. But I haven't checked the code.

Hmm, well, yeah...  A sync doesn=E2=80=99t necessarily mean settling all
in-flight requests.

> So I expect that calling fsync() on the lower layer does everything that
> is needed. Which is bdrv_flush() in QEMU.
>=20
>> Or is it the opposite, flush should just drain and not invoke
>> blk_flush()?  (Sorry, this all gets me confused every time.)
>=20
> I'm just relying on the libfuse documentation there for flush:
>=20
> "This is called on each close() of the opened file."

Ah, OK.

> and
>=20
> "NOTE: the name of the method is misleading, since (unlike fsync) the
> filesystem is not forced to flush pending writes. One reason to flush
> data is if the filesystem wants to return write errors during close.
> However, such use is non-portable because POSIX does not require close
> to wait for delayed I/O to complete."
>=20
>> (Though I do think .fsync should both flush and drain.)
>>
>>> Hmm, or maybe actually for both? We usually do bdrv_flush() during
>>> close, so it would be consistent to do the same here. It's our last
>>> chance to report an error to the user before the file is closed.
>>
>> I don=E2=80=99t understand what you mean.  What is =E2=80=9Cthe same=E2=
=80=9D?  Closing the
>> image?  Or indeed having .flush() be implemented with blk_flush()?
>=20
> Implementing .flush(), which will be called when the image is closed,
> with blk_flush().
>=20
> And still doing blk_flush() for .fsync, of course.

OK.

>> Do you mean that other parties may do the same as qemu does, i.e.
>> flush files before they are closed, which is why we should anticipate
>> the same and give users a chance to see errors?
>=20
> I'm not exactly sure what failure of .flush() would look like for users.
> Probably close() failing, so they don't have to do anything special,
> just check their return values.

Checking return values on close()?  Sounds special to me. O:)

Max


--eNoBbsi6lxCJY4sPaOdYQDhrBV7pZGv2W--

--Uk7pNtTh3cgxe7wooyWqadOyQ5O9sqC5u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl+IcxUACgkQ9AfbAGHV
z0AQkgf/VuvYs10eT/4bWOwU2L/ZL+wiWo8xA/m/11co20klM9E8L9+UeV0Ikvg0
8gFFIDqig6kTVJcDRvj5H1uBaiyA9gJSu4M5jugmI0gs9iGfvb4TChX+qa9Mz/sz
KuXTkPzoFnjTuGmCMPE/YKXytBNItAto2ERJQ9Q8jtVUqXlw8hX/iTOSChJmCyrK
kGV2Kx7Ro0dG4uOc2W9zfnTmMqcnO46+sWHifzbQmabCc92qzLPoeMs9P77N/p4F
WdCh+XU6O5UF8B7QWZM3vf0gXOO0iVUo70pdUIl48h+d+c9u4BYWN2uBs6X61PtP
rFTjcub8WvylcoPp0tfyFZ5ExdgspQ==
=/na0
-----END PGP SIGNATURE-----

--Uk7pNtTh3cgxe7wooyWqadOyQ5O9sqC5u--


