Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A77C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 09:02:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85E8C2166E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 09:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQMOEFlC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E8C2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFZWg-0000xK-JA
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 05:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kFZVj-0008Pj-UP
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 05:01:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36223
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kFZVf-0006aI-Cx
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 05:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599555709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zaPLorNxunFz0t2oW4xj4ZnIIbpm2B58xshtQVDRMUc=;
 b=aQMOEFlC6x9QfXUwpL7Uqr32rk08Zra64PVXso73MxL8evMYR/zkXIIg7royIhKQ3qNFba
 1UZMtLmJkikykZ7F04yOkC2mftD7WIBbd3z4phjcuO4nxj/92dW9mJWCX+rH57xtq7cDkT
 /N7/mw/6+0ZCi+o9F4TQMs8iEDiHXaE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-pQ6oCzQTOEufvRXETKio5Q-1; Tue, 08 Sep 2020 05:01:44 -0400
X-MC-Unique: pQ6oCzQTOEufvRXETKio5Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61A351007478;
 Tue,  8 Sep 2020 09:01:43 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-122.ams2.redhat.com
 [10.36.113.122])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F40AC5D9E2;
 Tue,  8 Sep 2020 09:01:41 +0000 (UTC)
Subject: Re: [PULL 00/64] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20200907110936.261684-1-kwolf@redhat.com>
 <CAFEAcA_woBi7gMG9vK7heTwc-uCee8q3O44Mq3icHvCk2bYNNg@mail.gmail.com>
 <20200908070126.GA8175@linux.fritz.box>
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
Message-ID: <e9245ecf-df81-654a-b718-a428568ff501@redhat.com>
Date: Tue, 8 Sep 2020 11:01:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908070126.GA8175@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HYf40KBINGr9dG8qV3rtISg9L97pSpt4d"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.825, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HYf40KBINGr9dG8qV3rtISg9L97pSpt4d
Content-Type: multipart/mixed; boundary="vXhL6ei3YzldhqV4UT0Xoi7GWiy7SJDgs"

--vXhL6ei3YzldhqV4UT0Xoi7GWiy7SJDgs
Content-Type: multipart/mixed;
 boundary="------------C3E529622683B48C936595CA"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------C3E529622683B48C936595CA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.09.20 09:01, Kevin Wolf wrote:
> Am 07.09.2020 um 22:22 hat Peter Maydell geschrieben:
>> On Mon, 7 Sep 2020 at 12:09, Kevin Wolf <kwolf@redhat.com> wrote:
>>>
>>> The following changes since commit 7c37270b3fbe3d034ba80e488761461676e2=
1eb4:
>>>
>>>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20200904-pull-re=
quest' into staging (2020-09-06 16:23:55 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>>>
>>> for you to fetch changes up to 4cc0ec9b1b8830f7d1fcf5dfded19ef070f98eaa=
:
>>>
>>>   block/nvme: Pair doorbell registers (2020-09-07 12:47:57 +0200)
>>>
>>> ----------------------------------------------------------------
>>> Block layer patches:
>>>
>>> - qemu-img create: Fail gracefully when backing file is an empty string
>>> - Fixes related to filter block nodes ("Deal with filters" series)
>>> - block/nvme: Various cleanups required to use multiple queues
>>> - block/nvme: Use NvmeBar structure from "block/nvme.h"
>>> - file-win32: Fix "locking" option
>>> - iotests: Allow running from different directory
>>
>> Fails in make check on iotests 040 and/or 041, various hosts:
>>
>> s390x linux:
>>
>>   TEST    iotest-qcow2: 041 [fail]
>> QEMU          --
>> "/home/ubuntu/qemu/build/all/tests/qemu-iotests/../../qemu-system-s390x"
>> -nodefaults -display none -accel qtest
>> QEMU_IMG      -- "/home/ubuntu/qemu/build/all/tests/qemu-iotests/../../q=
emu-img"
>> QEMU_IO       --
>> "/home/ubuntu/qemu/build/all/tests/qemu-iotests/../../qemu-io"
>> --cache writeback --aio threads -f qcow2
>> QEMU_NBD      -- "/home/ubuntu/qemu/build/all/tests/qemu-iotests/../../q=
emu-nbd"
>> IMGFMT        -- qcow2 (compat=3D1.1)
>> IMGPROTO      -- file
>> PLATFORM      -- Linux/s390x qemu01 4.15.0-72-generic
>> TEST_DIR      -- /home/ubuntu/qemu/build/all/tests/qemu-iotests/scratch
>> SOCK_DIR      -- /tmp/tmp.5Tpl6u2SCo
>> SOCKET_SCM_HELPER --
>> /home/ubuntu/qemu/build/all/tests/qemu-iotests/socket_scm_helper
>>
>> --- /home/ubuntu/qemu/tests/qemu-iotests/041.out        2020-09-07
>> 14:29:45.468466636 -0400
>> +++ /home/ubuntu/qemu/build/all/tests/qemu-iotests/041.out.bad
>> 2020-09-07 14:43:41.494989911 -0400
>> @@ -1,5 +1,29 @@
>> -.......................................................................=
....................................
>> +.FF....................................................................=
....................................
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +FAIL: test_explicit_mirror_filter (__main__.TestFilters)
>> +----------------------------------------------------------------------
>> +Traceback (most recent call last):
>> +  File "041", line 1415, in test_explicit_mirror_filter
>> +    self.assert_qmp(result, 'return', {})
>> +  File "/home/ubuntu/qemu/tests/qemu-iotests/iotests.py", line 888,
>> in assert_qmp
>> +    result =3D self.dictpath(d, path)
>> +  File "/home/ubuntu/qemu/tests/qemu-iotests/iotests.py", line 862, in =
dictpath
>> +    self.fail(f'failed path traversal for "{path}" in "{d}"')
>> +AssertionError: failed path traversal for "return" in "{'error':
>> {'class': 'GenericError', 'desc': "Device 'virtio-blk-ccw' can't go on
>> PCI bus"}}"
>=20
> Max, any specific reason you specified the bus in device_add?

No, I don=E2=80=99t think so.

> This seems to fix it for me. Do you agree with the change?
>=20
> diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
> index cdbef3ba20..203ed58868 100755
> --- a/tests/qemu-iotests/041
> +++ b/tests/qemu-iotests/041
> @@ -1376,7 +1376,6 @@ class TestFilters(iotests.QMPTestCase):
>          result =3D self.vm.qmp('device_add',
>                               driver=3D'virtio-blk',
>                               id=3D'virtio',
> -                             bus=3D'pci.0',
>                               drive=3D'source')
>          self.assert_qmp(result, 'return', {})
>=20
> @@ -1410,7 +1409,6 @@ class TestFilters(iotests.QMPTestCase):
>          result =3D self.vm.qmp('device_add',
>                               driver=3D'virtio-blk',
>                               id=3D'virtio',
> -                             bus=3D'pci.0',
>                               drive=3D'source')
>          self.assert_qmp(result, 'return', {})

Partially =E2=80=93 this still fails on FreeBSD just like 040 fails.  So as
discussed on IRC, we should probably make this add a scsi-hd device and
add a virtio-scsi device to the VM in setUp().

[...]

>> freebsd:
>>
>>   TEST    iotest-qcow2: 040 [fail]
>> QEMU          --
>> "/usr/home/qemu/qemu-test.6pxNB5/build/tests/qemu-iotests/../../qemu-sys=
tem-aarch64"
>> -nodefaults -display none -accel qtest -machine virt
>> QEMU_IMG      --
>> "/usr/home/qemu/qemu-test.6pxNB5/build/tests/qemu-iotests/../../qemu-img=
"
>> QEMU_IO       --
>> "/usr/home/qemu/qemu-test.6pxNB5/build/tests/qemu-iotests/../../qemu-io"
>>  --cache writeback --aio threads -f qcow2
>> QEMU_NBD      --
>> "/usr/home/qemu/qemu-test.6pxNB5/build/tests/qemu-iotests/../../qemu-nbd=
"
>> IMGFMT        -- qcow2 (compat=3D1.1)
>> IMGPROTO      -- file
>> PLATFORM      -- FreeBSD/amd64 freebsd 12.1-RELEASE
>> TEST_DIR      -- /home/qemu/qemu-test.6pxNB5/build/tests/qemu-iotests/sc=
ratch
>> SOCK_DIR      -- /tmp/tmp.gaJ11NA1
>> SOCKET_SCM_HELPER --
>>
>> --- /home/qemu/qemu-test.6pxNB5/src/tests/qemu-iotests/040.out
>> 2020-09-07 18:29:28.000000000 +0000
>> +++ /home/qemu/qemu-test.6pxNB5/build/tests/qemu-iotests/040.out.bad
>>  2020-09-07 18:37:26.783967000 +0000
>> @@ -1,5 +1,17 @@
>> -.................................................................
>> +....................F............................................
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +FAIL: test_filtered_active_commit_with_filter (__main__.TestCommitWithF=
ilters)
>>  ----------------------------------------------------------------------
>> +Traceback (most recent call last):
>> +  File "040", line 867, in test_filtered_active_commit_with_filter
>> +    self.assert_qmp(result, 'return', {})
>> +  File "/usr/home/qemu/qemu-test.6pxNB5/src/tests/qemu-iotests/iotests.=
py",
>> line 888, in assert_qmp
>> +    result =3D self.dictpath(d, path)
>> +  File "/usr/home/qemu/qemu-test.6pxNB5/src/tests/qemu-iotests/iotests.=
py",
>> line 862, in dictpath
>> +    self.fail(f'failed path traversal for "{path}" in "{d}"')
>> +AssertionError: failed path traversal for "return" in "{'error':
>> {'class': 'GenericError', 'desc': "Bus 'pcie.0' does not support
>> hotplugging"}}"
>=20
> This one I don't really understand. Why "pcie.0"? Do FreeBSD hosts
> default to a different machine type? The default should be the "pc"
> machine type, which has pci, not pcie.

As you=E2=80=99ve pointed out on IRC, this is for aarch64, so probably not =
so
much about the pc machine type.  Still, it passes on Linux, so there=E2=80=
=99s a
bit of a mystery still.

Anyway, using virtio-scsi + scsi-hd should make it pass.

I=E2=80=99ve attached a diff that makes =E2=80=9Cmake vm-build-freebsd=E2=
=80=9D (for aarch64)
pass for me.

Max

--------------C3E529622683B48C936595CA
Content-Type: text/plain; charset=UTF-8;
 name="diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff"

ZGlmZiAtLWdpdCBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8wNDAgYi90ZXN0cy9xZW11LWlvdGVzdHMv
MDQwCmluZGV4IDJhNTRmOWFkMjEuLmNhZjI4NjU3MWEgMTAwNzU1Ci0tLSBhL3Rlc3RzL3FlbXUt
aW90ZXN0cy8wNDAKKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzA0MApAQCAtNzYxLDcgKzc2MSw3
IEBAIGNsYXNzIFRlc3RDb21taXRXaXRoRmlsdGVycyhpb3Rlc3RzLlFNUFRlc3RDYXNlKToKIAog
ICAgICAgICBzZWxmLmRvX3Rlc3RfaW8oJ3dyaXRlJykKIAotICAgICAgICBzZWxmLnZtID0gaW90
ZXN0cy5WTSgpCisgICAgICAgIHNlbGYudm0gPSBpb3Rlc3RzLlZNKCkuYWRkX2RldmljZSgndmly
dGlvLXNjc2ksaWQ9dmlvLXNjc2knKQogICAgICAgICBzZWxmLnZtLmxhdW5jaCgpCiAKICAgICAg
ICAgcmVzdWx0ID0gc2VsZi52bS5xbXAoJ29iamVjdC1hZGQnLCBxb21fdHlwZT0ndGhyb3R0bGUt
Z3JvdXAnLCBpZD0ndGcnKQpAQCAtODYyLDggKzg2Miw4IEBAIGNsYXNzIFRlc3RDb21taXRXaXRo
RmlsdGVycyhpb3Rlc3RzLlFNUFRlc3RDYXNlKToKICAgICAgICAgIyBBZGQgYSBkZXZpY2UsIHNv
IHRoZSBjb21taXQgam9iIGZpbmRzIGEgcGFyZW50IGl0IGNhbiBjaGFuZ2UKICAgICAgICAgIyB0
byBwb2ludCB0byB0aGUgYmFzZSBub2RlIChzbyB3ZSBjYW4gdGVzdCB0aGF0IHRvcC1maWx0ZXIg
aXMKICAgICAgICAgIyBkcm9wcGVkIGZyb20gdGhlIGdyYXBoKQotICAgICAgICByZXN1bHQgPSBz
ZWxmLnZtLnFtcCgnZGV2aWNlX2FkZCcsIGlkPSdkcnYwJywgZHJpdmVyPSd2aXJ0aW8tYmxrJywK
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZHJpdmU9J3RvcC1maWx0ZXInKQorICAgICAg
ICByZXN1bHQgPSBzZWxmLnZtLnFtcCgnZGV2aWNlX2FkZCcsIGlkPSdkcnYwJywgZHJpdmVyPSdz
Y3NpLWhkJywKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnVzPSd2aW8tc2NzaS4wJywg
ZHJpdmU9J3RvcC1maWx0ZXInKQogICAgICAgICBzZWxmLmFzc2VydF9xbXAocmVzdWx0LCAncmV0
dXJuJywge30pCiAKICAgICAgICAgIyBUcnkgdG8gcmVsZWFzZSBvdXIgcmVmZXJlbmNlIHRvIHRv
cC1maWx0ZXI7IHRoYXQgc2hvdWxkIG5vdApAQCAtODg5LDcgKzg4OSw3IEBAIGNsYXNzIFRlc3RD
b21taXRXaXRoRmlsdGVycyhpb3Rlc3RzLlFNUFRlc3RDYXNlKToKIAogICAgICAgICAjIENoZWNr
IHRoYXQgZHJ2MCBpcyBub3cgY29ubmVjdGVkIHRvIGNvdy0yCiAgICAgICAgIGJsb2NrZGV2cyA9
IHNlbGYudm0ucW1wKCdxdWVyeS1ibG9jaycpWydyZXR1cm4nXQotICAgICAgICBkcnYwID0gbmV4
dChkZXYgZm9yIGRldiBpbiBibG9ja2RldnMgaWYgJy9kcnYwJyBpbiBkZXZbJ3FkZXYnXSkKKyAg
ICAgICAgZHJ2MCA9IG5leHQoZGV2IGZvciBkZXYgaW4gYmxvY2tkZXZzIGlmIGRldlsncWRldidd
ID09ICdkcnYwJykKICAgICAgICAgc2VsZi5hc3NlcnRFcXVhbChkcnYwWydpbnNlcnRlZCddWydu
b2RlLW5hbWUnXSwgJ2Nvdy0yJykKIAogICAgICAgICAjIDMgaGFzIGJlZW4gY29taXR0ZWQgaW50
byAyCmRpZmYgLS1naXQgYS90ZXN0cy9xZW11LWlvdGVzdHMvMDQxIGIvdGVzdHMvcWVtdS1pb3Rl
c3RzLzA0MQppbmRleCBjZGJlZjNiYTIwLi5hNzc4MDg1M2NkIDEwMDc1NQotLS0gYS90ZXN0cy9x
ZW11LWlvdGVzdHMvMDQxCisrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8wNDEKQEAgLTEzMDAsNyAr
MTMwMCw3IEBAIGNsYXNzIFRlc3RGaWx0ZXJzKGlvdGVzdHMuUU1QVGVzdENhc2UpOgogICAgICAg
ICBxZW11X2lvKCctYycsICd3cml0ZSAtUCAxIDAgNTEyaycsIGJhY2tpbmdfaW1nKQogICAgICAg
ICBxZW11X2lvKCctYycsICd3cml0ZSAtUCAyIDUxMmsgNTEyaycsIHRlc3RfaW1nKQogCi0gICAg
ICAgIHNlbGYudm0gPSBpb3Rlc3RzLlZNKCkKKyAgICAgICAgc2VsZi52bSA9IGlvdGVzdHMuVk0o
KS5hZGRfZGV2aWNlKCd2aXJ0aW8tc2NzaSxpZD12aW8tc2NzaScpCiAgICAgICAgIHNlbGYudm0u
bGF1bmNoKCkKIAogICAgICAgICByZXN1bHQgPSBzZWxmLnZtLnFtcCgnYmxvY2tkZXYtYWRkJywg
Kip7CkBAIC0xMzc0LDkgKzEzNzQsOSBAQCBjbGFzcyBUZXN0RmlsdGVycyhpb3Rlc3RzLlFNUFRl
c3RDYXNlKToKIAogICAgICAgICAjIFdlIG5lZWQgdGhpcyBzbyB3ZSBjYW4gcXVlcnkgZnJvbSBh
Ym92ZSB0aGUgbWlycm9yIG5vZGUKICAgICAgICAgcmVzdWx0ID0gc2VsZi52bS5xbXAoJ2Rldmlj
ZV9hZGQnLAotICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkcml2ZXI9J3ZpcnRpby1ibGsn
LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkcml2ZXI9J3Njc2ktaGQnLAogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBpZD0ndmlydGlvJywKLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgYnVzPSdwY2kuMCcsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJ1cz0n
dmlvLXNjc2kuMCcsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRyaXZlPSdzb3VyY2Un
KQogICAgICAgICBzZWxmLmFzc2VydF9xbXAocmVzdWx0LCAncmV0dXJuJywge30pCiAKQEAgLTEz
ODksOCArMTM4OSw4IEBAIGNsYXNzIFRlc3RGaWx0ZXJzKGlvdGVzdHMuUU1QVGVzdENhc2UpOgog
CiAgICAgICAgICMgVGhlIG1pcnJvciBmaWx0ZXIgaXMgbm93IGFuIGltcGxpY2l0IG5vZGUsIHNv
IGl0IHNob3VsZCBiZQogICAgICAgICAjIGludmlzaWJsZSB3aGVuIHF1ZXJ5aW5nIHRoZSBiYWNr
aW5nIGNoYWluCi0gICAgICAgIGRldmljZV9pbmZvID0gc2VsZi52bS5xbXAoJ3F1ZXJ5LWJsb2Nr
JylbJ3JldHVybiddWzBdCi0gICAgICAgIGFzc2VydCBkZXZpY2VfaW5mb1sncWRldiddID09ICcv
bWFjaGluZS9wZXJpcGhlcmFsL3ZpcnRpby92aXJ0aW8tYmFja2VuZCcKKyAgICAgICAgYmxvY2tk
ZXZzID0gc2VsZi52bS5xbXAoJ3F1ZXJ5LWJsb2NrJylbJ3JldHVybiddCisgICAgICAgIGRldmlj
ZV9pbmZvID0gbmV4dChkZXYgZm9yIGRldiBpbiBibG9ja2RldnMgaWYgZGV2WydxZGV2J10gPT0g
J3ZpcnRpbycpCiAKICAgICAgICAgYXNzZXJ0IGRldmljZV9pbmZvWydpbnNlcnRlZCddWydub2Rl
LW5hbWUnXSA9PSAnc291cmNlJwogCkBAIC0xNDA4LDkgKzE0MDgsOSBAQCBjbGFzcyBUZXN0Rmls
dGVycyhpb3Rlc3RzLlFNUFRlc3RDYXNlKToKIAogICAgICAgICAjIFdlIG5lZWQgdGhpcyBzbyB3
ZSBjYW4gcXVlcnkgZnJvbSBhYm92ZSB0aGUgbWlycm9yIG5vZGUKICAgICAgICAgcmVzdWx0ID0g
c2VsZi52bS5xbXAoJ2RldmljZV9hZGQnLAotICAgICAgICAgICAgICAgICAgICAgICAgICAgICBk
cml2ZXI9J3ZpcnRpby1ibGsnLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkcml2ZXI9
J3Njc2ktaGQnLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZD0ndmlydGlvJywKLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgYnVzPSdwY2kuMCcsCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGJ1cz0ndmlvLXNjc2kuMCcsCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGRyaXZlPSdzb3VyY2UnKQogICAgICAgICBzZWxmLmFzc2VydF9xbXAocmVzdWx0LCAncmV0
dXJuJywge30pCiAKQEAgLTE0MjQsOCArMTQyNCw4IEBAIGNsYXNzIFRlc3RGaWx0ZXJzKGlvdGVz
dHMuUU1QVGVzdENhc2UpOgogCiAgICAgICAgICMgV2l0aCBhIG5vZGUtbmFtZSBnaXZlbiB0byBp
dCwgdGhlIG1pcnJvciBmaWx0ZXIgc2hvdWxkIG5vdwogICAgICAgICAjIGJlIHZpc2libGUKLSAg
ICAgICAgZGV2aWNlX2luZm8gPSBzZWxmLnZtLnFtcCgncXVlcnktYmxvY2snKVsncmV0dXJuJ11b
MF0KLSAgICAgICAgYXNzZXJ0IGRldmljZV9pbmZvWydxZGV2J10gPT0gJy9tYWNoaW5lL3Blcmlw
aGVyYWwvdmlydGlvL3ZpcnRpby1iYWNrZW5kJworICAgICAgICBibG9ja2RldnMgPSBzZWxmLnZt
LnFtcCgncXVlcnktYmxvY2snKVsncmV0dXJuJ10KKyAgICAgICAgZGV2aWNlX2luZm8gPSBuZXh0
KGRldiBmb3IgZGV2IGluIGJsb2NrZGV2cyBpZiBkZXZbJ3FkZXYnXSA9PSAndmlydGlvJykKIAog
ICAgICAgICBhc3NlcnQgZGV2aWNlX2luZm9bJ2luc2VydGVkJ11bJ25vZGUtbmFtZSddID09ICdt
aXJyb3ItZmlsdGVyJwogCg==
--------------C3E529622683B48C936595CA--

--vXhL6ei3YzldhqV4UT0Xoi7GWiy7SJDgs--

--HYf40KBINGr9dG8qV3rtISg9L97pSpt4d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9XSHMACgkQ9AfbAGHV
z0CFFAgAv028nAMFjMbWdhiLVpwHS6Fmib4m2skI+3RXHlydqEu217CTpyqfuGL3
FDCnkVOdE/qbK+Pjor9G7T3PqynCdO/x6SxkCdBXXV1WHIKdG5IN4A4Y1xBad0cF
7zmTjna9z84SXRBbndf1AQ1HXb5Kux6q9BReTfsG7e+1a09V1q9NTRbyvTJbPXoi
fsqpctAYLRFeyWwo855Crn4c8XykHVTpvzyas6204Zq+34OrlJIudBGgWOEFu0IR
4f/WguP5wJqNK22WJQuWbrU7EQIL7Unn51zjkDKW6UIO/PY5r/K9YABshaPW19HJ
9PVl2C/4Hx9M2NqPheQtEif/lk0H0w==
=yBYW
-----END PGP SIGNATURE-----

--HYf40KBINGr9dG8qV3rtISg9L97pSpt4d--


