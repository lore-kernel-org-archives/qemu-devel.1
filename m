Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B004C3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 01:40:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 139F321D56
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 01:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139F321D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8wXr-0005pu-9L
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 20:40:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1j8wWz-0005G9-OS
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 20:39:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1j8wWy-0001do-IM
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 20:39:33 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:60122 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1j8wWs-0001a9-45; Mon, 02 Mar 2020 20:39:26 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 6EC95B4B880CE3007BD5;
 Tue,  3 Mar 2020 09:39:22 +0800 (CST)
Received: from [10.184.39.213] (10.184.39.213) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 3 Mar 2020
 09:39:12 +0800
Subject: Re: [PATCH v3 1/6] s390x: fix memleaks in cpu_finalize
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20200227025055.14341-1-pannengyuan@huawei.com>
 <20200227025055.14341-2-pannengyuan@huawei.com>
 <CAJSP0QXqOhrEz9T9=2bBO2kCqdRh+_O1+FM+TY66_gHMHY0mJw@mail.gmail.com>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <b2d6ad2a-22cc-f8bb-40f1-14fd02554492@huawei.com>
Date: Tue, 3 Mar 2020 09:39:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAJSP0QXqOhrEz9T9=2bBO2kCqdRh+_O1+FM+TY66_gHMHY0mJw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [10.184.39.213]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-s390x@nongnu.org,
 qemu-arm <qemu-arm@nongnu.org>, Euler Robot <euler.robot@huawei.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/2/2020 10:34 PM, Stefan Hajnoczi wrote:
> On Thu, Feb 27, 2020 at 2:42 AM Pan Nengyuan <pannengyuan@huawei.com> w=
rote:
>>
>> This patch fix memleaks when we call tests/qtest/cpu-plug-test on s390=
x. The leak stack is as follow:
>>
>> Direct leak of 48 byte(s) in 1 object(s) allocated from:
>>     #0 0x7fb43c7cd970 in __interceptor_calloc (/lib64/libasan.so.5+0xe=
f970)
>>     #1 0x7fb43be2149d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
>>     #2 0x558ba96da716 in timer_new_full /mnt/sdb/qemu-new/qemu/include=
/qemu/timer.h:530
>>     #3 0x558ba96da716 in timer_new /mnt/sdb/qemu-new/qemu/include/qemu=
/timer.h:551
>>     #4 0x558ba96da716 in timer_new_ns /mnt/sdb/qemu-new/qemu/include/q=
emu/timer.h:569
>>     #5 0x558ba96da716 in s390_cpu_initfn /mnt/sdb/qemu-new/qemu/target=
/s390x/cpu.c:285
>>     #6 0x558ba9c969ab in object_init_with_type /mnt/sdb/qemu-new/qemu/=
qom/object.c:372
>>     #7 0x558ba9c9eb5f in object_initialize_with_type /mnt/sdb/qemu-new=
/qemu/qom/object.c:516
>>     #8 0x558ba9c9f053 in object_new_with_type /mnt/sdb/qemu-new/qemu/q=
om/object.c:684
>>     #9 0x558ba967ede6 in s390x_new_cpu /mnt/sdb/qemu-new/qemu/hw/s390x=
/s390-virtio-ccw.c:64
>>     #10 0x558ba99764b3 in hmp_cpu_add /mnt/sdb/qemu-new/qemu/hw/core/m=
achine-hmp-cmds.c:57
>>     #11 0x558ba9b1c27f in handle_hmp_command /mnt/sdb/qemu-new/qemu/mo=
nitor/hmp.c:1082
>>     #12 0x558ba96c1b02 in qmp_human_monitor_command /mnt/sdb/qemu-new/=
qemu/monitor/misc.c:142
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
>> ---
>> Cc: Richard Henderson <rth@twiddle.net>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Cornelia Huck <cohuck@redhat.com>
>> Cc: qemu-s390x@nongnu.org
>> ---
>> v2->v1:
>> - Similarly to other cleanups, move timer_new into realize(Suggested b=
y Philippe Mathieu-Daud=C3=A9)
>=20
> Hi,
> This email is invalid and cannot be parsed by the patches
> (https://github.com/stefanha/patches) tool that is used by some QEMU
> maintainers to apply patches.
>=20
> The character set is incorrectly set to "base64", which is a content
> transfer encoding and not a character set:
>=20
>   Content-Type: text/plain; charset=3D"base64"
>   Content-Transfer-Encoding: quoted-printable
>=20
> There is a UTF-8 =C3=A9 character here:
>=20
>   - Similarly to other cleanups, move timer_new into realize(Suggested =
by Phi=3D
>   lippe Mathieu-Daud=3DC3=3DA9)
>=20
> Since there is no valid charset the =C3=A9 character cannot be decoded.
>=20
> This might be a mail server problem but it could also be due to your
> git-send-email(1) configuration.
>=20
> Did you set the charset to "base64" or override the content transfer
> encoding?  I think other people on the list will have trouble
> receiving emails like this too.

Yes, it's set to "base64", I will correct it.

Thanks.

>=20
> Stefan
> .
>=20

