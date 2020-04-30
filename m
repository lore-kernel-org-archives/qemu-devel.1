Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A93C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:39:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 505F52076D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jPzcZO8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505F52076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7Xk-0006iN-Hk
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jU7X8-0005gj-R8
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:39:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jU7X7-0007NJ-Gv
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:39:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57812
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jU7X7-0007NC-0K
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588246750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9Q5OvfBkfU6LhdGqKO3mzpV0MFYFGesscIJf/yFA08M=;
 b=jPzcZO8rcj7SMzcbj6L8WPlPQCE+j0RNAk2b6tSZSLUllbHM5xbReuJV0WIr7/GfxKaXUm
 VETt8V0+n49W5JgsyHMc1SNKEo1yKK1Ku3zOdYUS7Q/Iggcv1obVXmd2EN1klk0DhwWUjb
 Jn/wdh08oveHXPPBX3tkqjgQQyn5HLg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-tK7mMk4MNIyFCJKYaz3Ypw-1; Thu, 30 Apr 2020 07:39:08 -0400
X-MC-Unique: tK7mMk4MNIyFCJKYaz3Ypw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 220BB19057A3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:39:07 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-177.ams2.redhat.com
 [10.36.112.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EFC85EDE5;
 Thu, 30 Apr 2020 11:38:59 +0000 (UTC)
Subject: Re: [PATCH] virtiofsd: Show submounts
From: Max Reitz <mreitz@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200424133516.73077-1-mreitz@redhat.com>
 <20200427175902.GM2923@work-vm> <20200429145720.GA2835@work-vm>
 <8c73f374-fcc8-1684-b581-84a9ab501aa9@redhat.com>
 <20200430085812.GC2874@work-vm>
 <94924861-d934-0151-aca5-19ea9eb211e1@redhat.com>
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
Message-ID: <7bca4d0d-5735-b8ca-4b30-21fc47f10c69@redhat.com>
Date: Thu, 30 Apr 2020 13:38:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <94924861-d934-0151-aca5-19ea9eb211e1@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Cr0jppYxlnBJVPb5HB4AGEm5hfWattA5y"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:31:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Cr0jppYxlnBJVPb5HB4AGEm5hfWattA5y
Content-Type: multipart/mixed; boundary="2HNnvSZGdCtjcq5p8D5Jlv4N6PB4CzrpT"

--2HNnvSZGdCtjcq5p8D5Jlv4N6PB4CzrpT
Content-Type: multipart/mixed;
 boundary="------------2F7EFAE0B68055935B9B9592"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------2F7EFAE0B68055935B9B9592
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.04.20 11:21, Max Reitz wrote:
> On 30.04.20 10:58, Dr. David Alan Gilbert wrote:
>> * Max Reitz (mreitz@redhat.com) wrote:
>>> On 29.04.20 16:57, Dr. David Alan Gilbert wrote:
>>>> * Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
>>>>> * Max Reitz (mreitz@redhat.com) wrote:
>>>>>> Currently, setup_mounts() bind-mounts the shared directory without
>>>>>> MS_REC.  This makes all submounts disappear.
>>>>>>
>>>>>> Pass MS_REC so that the guest can see submounts again.
>>>>>
>>>>> Thanks!
>>>>>
>>>>>> Fixes: 3ca8a2b1c83eb185c232a4e87abbb65495263756
>>>>>
>>>>> Should this actually be 5baa3b8e95064c2434bd9e2f312edd5e9ae275dc ?
>>>>>
>>>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>>>> ---
>>>>>>  tools/virtiofsd/passthrough_ll.c | 2 +-
>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/pass=
through_ll.c
>>>>>> index 4c35c95b25..9d7f863e66 100644
>>>>>> --- a/tools/virtiofsd/passthrough_ll.c
>>>>>> +++ b/tools/virtiofsd/passthrough_ll.c
>>>>>> @@ -2643,7 +2643,7 @@ static void setup_mounts(const char *source)
>>>>>>      int oldroot;
>>>>>>      int newroot;
>>>>>> =20
>>>>>> -    if (mount(source, source, NULL, MS_BIND, NULL) < 0) {
>>>>>> +    if (mount(source, source, NULL, MS_BIND | MS_REC, NULL) < 0) {
>>>>>>          fuse_log(FUSE_LOG_ERR, "mount(%s, %s, MS_BIND): %m\n", sour=
ce, source);
>>>>>>          exit(1);
>>>>>>      }
>>>>>
>>>>> Do we want MS_SLAVE to pick up future mounts that might happenf rom t=
he
>>>>> host?
>>>>> What's the interaction between this and the MS_REC|MS_SLAVE that we h=
ave
>>>>> a few lines above for / ?
>>>>
>>>> Just to confirm something from vgoyal, and what had confused me about
>>>> why we hadn't spotted this earlier.
>>>>
>>>> Even without this patch, the SLAVE stuff worked so if you start the
>>>> daemon and *then* mount under the shared directory, the guest sees it
>>>> with or without this patch.
>>>
>>> Hm, I don=E2=80=99t.  Do you really?
>>
>> Yes! With your patch reverted:
>>
>> Start virtiofsd, mount in the guest:
>>
>> host:
>> # ./virtiofsd --socket-path=3D/tmp/vhostqemu -o source=3D/home/dgilbert/=
virtio-fs/fs  -o log_level=3Dwarn -o no_writeback
>>
>> guest:
>> # mount -t virtiofs myfs /sysroot
>=20
> OK, for some reason I didn=E2=80=99t try to mount in the guest first, but=
 did
> the host mount after starting virtiofsd.
>=20
> My mount test uses multiple mounts, and two of them I see mounted, but
> three I still don=E2=80=99t see mounted.

And if I do a find /sysroot (or find /mnt in my case) in the guest
before mounting anything on the host, the mounts don=E2=80=99t appear in th=
e
guest at all, but that=E2=80=99s kind of a virtiofsd bug (or feature?).  Th=
at
is, if it has opened some directory before it became a mountpoint, then
it stays not-a-mountpoint.

> Let me see whether I can come up with something reproducible that isn=E2=
=80=99t
> a script.

Unfortunately, I can=E2=80=99t.  I=E2=80=99ve attached the script.

It launches qemu, then in the guest you have to mount =E2=80=9Chost=E2=80=
=9D somewhere
(before the script emits =E2=80=9Cmounting=E2=80=9D, ideally).

I can see that in the guest, mnt0-0 is mounted, and mnt0-0/sub is, too,
but mnt0-1 and mnt1 aren=E2=80=99t.

With this patch here, everything is mounted.

Max

--------------2F7EFAE0B68055935B9B9592
Content-Type: application/x-shellscript;
 name="test.sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="test.sh"

IyEvYmluL3NoCgpzZXQgLWUKCiNzdWRvIHNoIC1jICcuL3ZpcnRpb2ZzZCAtLXNvY2tldC1wYXRo
PS90bXAvdmZzZHNvY2swIC1vIHNvdXJjZT0kUFdEL3ZpcnRpb2ZzLXNoYXJlZCAtbyBjYWNoZT1h
bHdheXMgLWYgJicKc3VkbyBzaCAtYyAnLi92aXJ0aW9mc2QgLS1zb2NrZXQtcGF0aD0vdG1wL3Zm
c2Rzb2NrMCAtbyBzb3VyY2U9JFBXRC92aXJ0aW9mcy1zaGFyZWQgLW8gbm9fd3JpdGViYWNrICYn
CgpzbGVlcCAxCgpzdWRvIGNobW9kIGdvK3J3IC90bXAvdmZzZHNvY2swCgojIFRPRE86IEFkZCB5
b3VyIGFyZ3VtZW50cyB0byBydW4gc29tZSB0ZXN0IHN5c3RlbQp4ODZfNjQtc29mdG1tdS9xZW11
LXN5c3RlbS14ODZfNjQgXAogICAgLWFjY2VsIGt2bSAtbSA0RyBcCiAgICAtY2hhcmRldiBzb2Nr
ZXQsaWQ9dmZzZHNvY2swLHBhdGg9L3RtcC92ZnNkc29jazAgXAogICAgLWRldmljZSB2aG9zdC11
c2VyLWZzLXBjaSxxdWV1ZS1zaXplPTEwMjQsY2hhcmRldj12ZnNkc29jazAsdGFnPWhvc3QgXAog
ICAgLW9iamVjdCBtZW1vcnktYmFja2VuZC1maWxlLGlkPW1lbSxzaXplPTRHLG1lbS1wYXRoPS9k
ZXYvc2htLHNoYXJlPW9uIFwKICAgIC1udW1hIG5vZGUsbWVtZGV2PW1lbSAmCgpzbGVlcCAxCgpy
bSAtZiBmczAuaW1nIGZzMS5pbWcgZnMyLmltZwoKdHJ1bmNhdGUgLXMgNTEyTSBmczAuaW1nCnRy
dW5jYXRlIC1zIDUxMk0gZnMxLmltZwp0cnVuY2F0ZSAtcyA1MTJNIGZzMi5pbWcKCm1rZnMueGZz
IC1xIGZzMC5pbWcKCnNsZWVwIDEKCnJtIC1mIGZzMC5pbWcgZnMxLmltZyBmczIuaW1nCgp0cnVu
Y2F0ZSAtcyA1MTJNIGZzMC5pbWcKdHJ1bmNhdGUgLXMgNTEyTSBmczEuaW1nCnRydW5jYXRlIC1z
IDUxMk0gZnMyLmltZwoKbWtmcy54ZnMgLXEgZnMwLmltZwpta2ZzLnhmcyAtcSBmczEuaW1nCm1r
ZnMueGZzIC1xIGZzMi5pbWcKCnN1ZG8gbWtkaXIgLXAgdmlydGlvZnMtc2hhcmVkL21udDAtMApz
dWRvIG1rZGlyIC1wIHZpcnRpb2ZzLXNoYXJlZC9tbnQwLTEKc3VkbyBta2RpciAtcCB2aXJ0aW9m
cy1zaGFyZWQvbW50MQoKc3VkbyB0b3VjaCB2aXJ0aW9mcy1zaGFyZWQvbW50MC0wLzAtMC1ub3Qt
bW91bnRlZApzdWRvIHRvdWNoIHZpcnRpb2ZzLXNoYXJlZC9tbnQwLTEvMC0xLW5vdC1tb3VudGVk
CnN1ZG8gdG91Y2ggdmlydGlvZnMtc2hhcmVkL21udDEvMS1ub3QtbW91bnRlZAoKZm9yIGkgaW4g
JChzZXEgMCA1OSk7IGRvCiAgICBlY2hvICJNb3VudGluZyBpbiAkKCg2MCAtIGkpKSBzIgogICAg
c2xlZXAgMQpkb25lCgpkZXYwPSQoc3VkbyBsb3NldHVwIC1mIC0tc2hvdyBmczAuaW1nKQpkZXYx
PSQoc3VkbyBsb3NldHVwIC1mIC0tc2hvdyBmczEuaW1nKQpkZXYyPSQoc3VkbyBsb3NldHVwIC1m
IC0tc2hvdyBmczIuaW1nKQoKc3VkbyBtb3VudCAiJGRldjAiIHZpcnRpb2ZzLXNoYXJlZC9tbnQw
LTAKc3VkbyB0b3VjaCB2aXJ0aW9mcy1zaGFyZWQvbW50MC0wL2RldjAtbW91bnRlZApzdWRvIG1v
dW50ICIkZGV2MCIgdmlydGlvZnMtc2hhcmVkL21udDAtMQoKc3VkbyBta2RpciAtcCB2aXJ0aW9m
cy1zaGFyZWQvbW50MC0wL3N1YgpzdWRvIHRvdWNoIHZpcnRpb2ZzLXNoYXJlZC9tbnQwLTAvc3Vi
L2RldjItbm90LW1vdW50ZWQKc3VkbyBtb3VudCAiJGRldjIiIHZpcnRpb2ZzLXNoYXJlZC9tbnQw
LTAvc3ViCnN1ZG8gdG91Y2ggdmlydGlvZnMtc2hhcmVkL21udDAtMC9zdWIvZGV2Mi1tb3VudGVk
CgpzdWRvIG1vdW50ICIkZGV2MSIgdmlydGlvZnMtc2hhcmVkL21udDEKc3VkbyB0b3VjaCB2aXJ0
aW9mcy1zaGFyZWQvbW50MS9kZXYxLW1vdW50ZWQKCnN1ZG8gbWtkaXIgLXAgdmlydGlvZnMtc2hh
cmVkL21udDEvc3ViMApzdWRvIHRvdWNoIHZpcnRpb2ZzLXNoYXJlZC9tbnQxL3N1YjAvZGV2Mi1u
b3QtbW91bnRlZAoKc3VkbyBtb3VudCAiJGRldjAiIHZpcnRpb2ZzLXNoYXJlZC9tbnQxL3N1YjAK
CmVjaG8gJ01vdW50ZWQnCgp3YWl0CgpzdWRvIHVtb3VudCB2aXJ0aW9mcy1zaGFyZWQvbW50MC0w
L3N1YgpzdWRvIHVtb3VudCB2aXJ0aW9mcy1zaGFyZWQvbW50MC0wCnN1ZG8gdW1vdW50IHZpcnRp
b2ZzLXNoYXJlZC9tbnQwLTEKc3VkbyB1bW91bnQgdmlydGlvZnMtc2hhcmVkL21udDEvc3ViMApz
dWRvIHVtb3VudCB2aXJ0aW9mcy1zaGFyZWQvbW50MQoKc3VkbyBsb3NldHVwIC1kICIkZGV2MCIK
c3VkbyBsb3NldHVwIC1kICIkZGV2MSIKc3VkbyBsb3NldHVwIC1kICIkZGV2MiIK
--------------2F7EFAE0B68055935B9B9592--

--2HNnvSZGdCtjcq5p8D5Jlv4N6PB4CzrpT--

--Cr0jppYxlnBJVPb5HB4AGEm5hfWattA5y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6quNIACgkQ9AfbAGHV
z0CtEwgAjk7iJ2ZogEkcbY0K65SNx4q99ZhXoMT35dqZpXXlDr+B6oW1oC6sDHVH
wkOli1vzer1cgrBITm/pfoC36dlX8WHZ+4s3/riMVoLJSRm5v62oSaQKrHj8jno6
EO8UQo09FBOKHjdjwELqeupXIyUP1oUSTfrm9Fb8czJ2INSr0khABX/KjUiA6130
XZQJLwPEccY+k0XiD7LUfUrMm87NFg2Bx9vJGbZzirHbc6391fA5doIklIAoONxP
OpQ5innr4IBjEh+qS7dzvoUggKPQ/j7ipxYsrOjLADWFyCvBnBUL4Ng8Hk4k5TvH
CGgJvV6U/GY15OIgHVVj8NMFqwsBcQ==
=KHxH
-----END PGP SIGNATURE-----

--Cr0jppYxlnBJVPb5HB4AGEm5hfWattA5y--


