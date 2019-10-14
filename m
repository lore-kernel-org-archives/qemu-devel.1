Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A348ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 10:23:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 238442064A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 10:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238442064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJxVY-0007Vm-94
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 06:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iJxUZ-0006uR-65
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:22:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iJxUW-00025S-8n
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:22:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59772)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iJxUW-00021y-0l
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:22:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 80FEB883832;
 Mon, 14 Oct 2019 10:22:13 +0000 (UTC)
Received: from [10.36.116.28] (ovpn-116-28.ams2.redhat.com [10.36.116.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 81CE55C1D4;
 Mon, 14 Oct 2019 10:22:12 +0000 (UTC)
Subject: Re: [Bug 1847232] [NEW] qemu TCG in s390x mode issue with calculating
 HASH
From: David Hildenbrand <david@redhat.com>
To: Ivan Warren <ivan@vmfacility.fr>, Cornelia Huck <cohuck@redhat.com>,
 Bug 1847232 <1847232@bugs.launchpad.net>
References: <157053356610.22354.6751604707489617887.malonedeb@gac.canonical.com>
 <20191008141135.11f5a065.cohuck@redhat.com>
 <61ce859f-0817-0eba-7eb8-2c16b3e73889@redhat.com>
 <7a661e58-72df-94bc-4712-f306ce5ee7c6@vmfacility.fr>
 <8ada8acb-d2ce-a09d-6c9a-b758360edcb2@redhat.com>
Organization: Red Hat GmbH
Message-ID: <4115ee76-8f74-cce2-348b-44752cd402ed@redhat.com>
Date: Mon, 14 Oct 2019 12:22:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <8ada8acb-d2ce-a09d-6c9a-b758360edcb2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Mon, 14 Oct 2019 10:22:13 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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

On 14.10.19 11:53, David Hildenbrand wrote:
> On 08.10.19 16:11, Ivan Warren wrote:
>>
>> On 10/8/2019 3:35 PM, David Hildenbrand wrote:
>>> On 08.10.19 14:11, Cornelia Huck wrote:
>>>> On Tue, 08 Oct 2019 11:19:25 -0000
>>>> Ivan Warren via <qemu-devel@nongnu.org> wrote:
>>>>
>>>>> Public bug reported:
>>>>>
>>>>> When using go on s390x on Debian x64 (buster) (host) and debian s39=
0x
>>>>> (sid) (guest) I run into the following problem :
>>>>>
>>>>> The following occurs while trying to build a custom project :
>>>>>
>>>>> go: github.com/FactomProject/basen@v0.0.0-20150613233007-fe3947df71=
6e:
>>>>> Get
>>>>> https://proxy.golang.org/github.com/%21factom%21project/basen/@v/v0=
.0.0-20150613233007-fe3947df716e.mod:
>>>>> local error: tls: bad record MAC
>>>>>
>>>>> Doing a git bisect I find that this problem only occurs on and afte=
r
>>>>> commit 08ef92d556c584c7faf594ff3af46df456276e1b
>>>>>
>>>>> Before that commit, all works fine. Past this commit, build always
>>>>> fails.
>>>> What version are you using? Current master?
>>>>
>>>> Can you please share your command line?
>>>>
>>>>> Without any proof, It looks like a hash calculation bug related to =
using
>>>>> z/Arch vector facilities...
>>>> Not an unreasonable guess, cc:ing David in case he has seen that bef=
ore.
>>>>
>>> Can you reproduce with "-cpu qemu,vx=3Doff" added to the QEMU command
>>> line? Could be some fallout from vector instruction support. Currentl=
y
>>> ill, will have a look when I'm feeling better.
>>
>> Reposted with a reply all... (sorry for the duplicates)
>>
>> So it does !
>>
>>
>> My qemu command line is now (forget the odd funny networking things..)
>>
>> qemu-system-s390x \
>>    =C2=A0=C2=A0=C2=A0 -drive
>> file=3DDEB002.IMG.NEW,discard=3Dunmap,cache=3Dwriteback,id=3Ddrive-0,i=
f=3Dnone \
>>    =C2=A0=C2=A0=C2=A0 -device virtio-scsi-ccw,id=3Dvirtio-scsi-0 \
>>    =C2=A0=C2=A0=C2=A0 -device scsi-hd,id=3Dscsi-hd-0,drive=3Ddrive-0 \
>>    =C2=A0=C2=A0=C2=A0 -m 8G \
>>    =C2=A0=C2=A0=C2=A0 -net nic,macaddr=3D52:54:00:00:00:02 \
>>    =C2=A0=C2=A0=C2=A0 -net tap,ifname=3Dtaparm,script=3Dno \
>>    =C2=A0=C2=A0=C2=A0 -nographic -accel tcg,thread=3Dmulti \
>>    =C2=A0=C2=A0=C2=A0 -monitor unix:ms,server,nowait \
>>    =C2=A0=C2=A0=C2=A0 -cpu qemu,vx=3Doff \=C2=A0 ##### THAT WAS ADDED =
as instructed - without it
>> everything goes kaput !
>>    =C2=A0=C2=A0=C2=A0 -smp 12
>>
>> And using the latest bleeding edge qemu from github, my build works (t=
he
>> problem goes away).
>>
>> So the z/Arch vector instructions may have a glitch is a venue to
>> consider.. Probably one that couldn't be screened through conventional
>> methods.
>>
>> I'm not that versed into z/Arch vector instruction, but if there
>> anything I can help with, I will !
>=20
> I'll have to reproduce, can you outline the steps needed to trigger
> this? (never had to build a go project before #luckyme ( ;) )). It look=
s
> like https://github.com/FactomProject/basen is getting pulled in from
> some other project?
>=20

I just tried with Fedora 31 Nightly using "go get"

[root@f31 ~]# go get -v -d github.com/FactomProject/factom
github.com/FactomProject/factom (download)
github.com/FactomProject/btcutil (download)
github.com/FactomProject/ed25519 (download)
github.com/FactomProject/go-bip32 (download)
github.com/FactomProject/btcutilecc (download)
package golang.org/x/crypto/ripemd160: unrecognized import path "golang.o=
rg/x/crypto/ripemd160" (https fetch: Get https://golang.org/x/crypto/ripe=
md160?go-get=3D1: local error: tls: bad record MAC)
github.com/FactomProject/go-bip39 (download)
package golang.org/x/crypto/pbkdf2: unrecognized import path "golang.org/=
x/crypto/pbkdf2" (https fetch: Get https://golang.org/x/crypto/pbkdf2?go-=
get=3D1: local error: tls: bad record MAC)
github.com/FactomProject/go-bip44 (download)
github.com/FactomProject/netki-go-partner-client (download)
github.com/FactomProject/go-simplejson (download)

With vx=3Doff:

[root@f31 ~]# go get -v -d github.com/FactomProject/factom
github.com/FactomProject/factom (download)
github.com/FactomProject/btcutil (download)
github.com/FactomProject/ed25519 (download)
github.com/FactomProject/go-bip32 (download)
github.com/FactomProject/basen (download)
github.com/FactomProject/btcutilecc (download)
get "golang.org/x/crypto/ripemd160": found meta tag get.metaImport{Prefix=
:"golang.org/x/crypto", VCS:"git", RepoRoot:"https://go.googlesource.com/=
crypto"} at //golang.org/x/crypto/ripemd160?go-get=3D1
get "golang.org/x/crypto/ripemd160": verifying non-authoritative meta tag
golang.org/x/crypto (download)
github.com/FactomProject/go-bip39 (download)
github.com/FactomProject/go-bip44 (download)
github.com/FactomProject/netki-go-partner-client (download)
github.com/FactomProject/go-simplejson (download)


That should be sufficient to identify the instruction. Might take some ti=
me, though. E.g.,
the HASH calculation in the kernel works just fine.

--=20

Thanks,

David / dhildenb

