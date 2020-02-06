Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8183CC33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:35:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F47820659
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZCalWhW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F47820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izlzT-0003Af-EP
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 13:35:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34318)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ldoktor@redhat.com>) id 1izlyO-0001pH-1J
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:33:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ldoktor@redhat.com>) id 1izlyL-00068P-JP
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:33:55 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51233
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1izlyL-00066G-CK
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:33:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581014032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wmEGw0cbpXc27XO0LhPNp0S/o61qaUwi8y8w/6R5/IM=;
 b=WZCalWhWDqskmfEd3QhXhS03Y2OwG/hUcrXxfLRtHvcGyW8wBKaqHIVmLhwTp1ged5Bjig
 UTo74gdUxM8cP78xLX1rHzZ72c4HLkk/hwqxFbY8u3d/RUzBfxZZhl0OE7S4KhSNoDmuqj
 iplxBZdeF0Fo3T7kGXt4IazFNPXXIwQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-MilgQ7rpMzqlU_avyG9yPg-1; Thu, 06 Feb 2020 13:33:37 -0500
X-MC-Unique: MilgQ7rpMzqlU_avyG9yPg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EC81DB2E;
 Thu,  6 Feb 2020 18:33:36 +0000 (UTC)
Received: from localhost.localdomain (ovpn-204-27.brq.redhat.com
 [10.40.204.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B2802790F0;
 Thu,  6 Feb 2020 18:33:31 +0000 (UTC)
Subject: Re: [PATCH] tests/qemu_iotests: Minimize usage of used ports
To: Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org
References: <20200203075955.28861-1-ldoktor@redhat.com>
 <fe6a7eb5-352a-3cb5-4e75-bd99baf6d54e@redhat.com>
 <595ffedf-4213-f000-96e1-3216e272b1c1@redhat.com>
 <726ca911-be83-c2d5-ff3f-efa32bc2233e@redhat.com>
 <797578d5-bfab-5eb7-8921-0fcf1f3ee40e@redhat.com>
 <6dcc60d8-3f3f-46bc-e3ca-c0569f9b0e23@redhat.com>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Autocrypt: addr=ldoktor@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFcV6vsBCADa8NUYov+a+AmCEEUB3stiiMM0NQc1WwlcxGoMxKHcqqIj/kdPhUDvFS32
 V94V7en1Lx+cpXKRMZP3n+3WG+VZWLwaktJgqrECZ161zE7xF5d1H3CLmwStbe6Cw1oR4LYQ
 HBpuqFEA5znoLuTTsP1uXs9h1cYNzX7hmOTvPCLJfDJ1iv954FsgCGtoVvl4CoxaR3u2VNOs
 hXsTTVyJM6gDTsyqn0uvLOHGWGIGVhDkLV4hv6pSdiKrtQKWIUji3Z8x41MbZybmJxHkpOVz
 Jl3jnNE3CbiEq77Is9LMI4yTF2CESs3V4XMBLfZPLrQBC0gzjeRxwCnbdOZRwY5KI457ABEB
 AAG0K0x1a2FzIERva3RvciAoUmVkIEhhdCkgPGxkb2t0b3JAcmVkaGF0LmNvbT6JAVQEEwEI
 AD8CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEF
 Al4caiwFCQsFbrUACgkQJrNi5H/PIsErWAf2OeTv2KSo5ukikdSA/iNItDXqqMhgrN0JbMad
 b82VYKKCFP+NXQy26NQqcKjaJlmv1Q4rYDfLvz+1gvnir6l9gg47g/EPC5s2UxGOlGz8fzgH
 cHne02PFEUKCNSlSZTJW8DCwFKN4VkPGqungJvDd9i8gC9B/TB3HH4IHr82mA3BnQ3wml9KH
 KXRoEJVR15cd6kKU55MRG0mq6VzYnW5Wwyxf0ZC6+R2tQgzxsvxRVPvQXSbcGv3kWoPgRo5a
 8IWzMB194tWVYNaqhMUPKZsgBUGF3JdzrwgDBAuC16mKgyMDrzH3X0ZZ3TXH+mQBXu/px5L8
 BMz/WAibkjPVTeqeuQENBFcV6vsBCADDwkgr2llR9lY1mKsEjA56+R1m7VouGAfzgR9fDjTK
 cwQVrW39zRto6K4s1xVt2ccsa9QBAnag3/6t0akRYhNVKMPEVh/ck6fJJkmEudCAYwbiPeZ0
 Vky5s8bUYkS65s8AAHSG5F+NBO86+kgrTcnYflwyi6DzrY4c6dP6Z+icau5ORI7Q8GrfC18/
 5neAsK4QOSYRlKHggrGzQKgtTgrFZFAemhM7FwCIfOPxybmpu7cJvUqtfPx0SZiEKrZ+kV/+
 H4Z8Q7yBT8gIkPxZBQdhxUrRtuJmyQJxI4a1K2PCrRCqK1kxtyw8Sx63/YvfPjgws+5UCm9z
 3A5Gz/eJP0GHABEBAAGJATwEGAEIACYCGwwWIQSkCkxFxANN4Cpa1IMms2Lkf88iwQUCXhxq
 TwUJCwVutQAKCRAms2Lkf88iwdfeCACyrlND9Kk27optBo2LMBJmoJAOJTl4o8YvWkrGFzK5
 NxWCpaRJCOCfQanACRDW3oEyd4CdLF4GXWsGhIgGymP2+/McpZXJdFwgHNQWtyZ8GHJW/TXr
 GphJ9FLskb2xh83RrLYy29eF+GeZcVLsGP1ZCLz3I6byhbEfklqKymB1q4bQl2cEijm/VK25
 cYpTtNa0SZiNCmfGqfQ60BtDHCjZm1x9GO+67pJmL2FuO0Tq2TtT+SgU1ZKbSYdPWPk2ZetD
 8RRkaPlrVRVGgW1w1/pCS29BHWaazjkmAVHE2Idh6O+7usA/G1Q3OEjWmJpmfwyKHI/rMv/f
 zMoMrrqg5DNH
Message-ID: <2958ad49-32c2-2157-2d88-7ec8ad14a5ef@redhat.com>
Date: Thu, 6 Feb 2020 19:33:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <6dcc60d8-3f3f-46bc-e3ca-c0569f9b0e23@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EcXrAFfVir2gw809V9BQY7uu1Zj9JbOgt"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EcXrAFfVir2gw809V9BQY7uu1Zj9JbOgt
Content-Type: multipart/mixed; boundary="2Mqm5OAHAeTCVwglMdrmK4a2JXOGQEkPN"

--2Mqm5OAHAeTCVwglMdrmK4a2JXOGQEkPN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Dne 06. 02. 20 v 17:59 Max Reitz napsal(a):
> On 06.02.20 17:48, Eric Blake wrote:
>> On 2/6/20 10:37 AM, Max Reitz wrote:
>>
>>>>
>>>> thank you and I am sorry for not digging deep enough. This week my CI
>>>> failed with:
>>>>
>>>> 01:24:06 DEBUG| [stdout] +ERROR: test_inet (__main__.QemuNBD)
>>>> 01:24:06 DEBUG| [stdout]
>>>> +---------------------------------------------------------------------=
-
>>>> 01:24:06 DEBUG| [stdout] +Traceback (most recent call last):
>>>> 01:24:06 DEBUG| [stdout] +=C2=A0 File "147", line 85, in setUp
>>>> 01:24:06 DEBUG| [stdout] +=C2=A0=C2=A0=C2=A0 self.vm.launch()
>>>> 01:24:06 DEBUG| [stdout] +=C2=A0 File
>>>> "/home/jenkins/ppc64le/qemu-master/tests/qemu-iotests/../../python/qem=
u/machine.py",
>>>> line 302, in launch
>>>> 01:24:06 DEBUG| [stdout] +=C2=A0=C2=A0=C2=A0 self._launch()
>>>> 01:24:06 DEBUG| [stdout] +=C2=A0 File
>>>> "/home/jenkins/ppc64le/qemu-master/tests/qemu-iotests/../../python/qem=
u/machine.py",
>>>> line 319, in _launch
>>>> 01:24:06 DEBUG| [stdout] +=C2=A0=C2=A0=C2=A0 self._pre_launch()
>>>> 01:24:06 DEBUG| [stdout] +=C2=A0 File
>>>> "/home/jenkins/ppc64le/qemu-master/tests/qemu-iotests/../../python/qem=
u/qtest.py",
>>>> line 106, in _pre_launch
>>>> 01:24:06 DEBUG| [stdout] +=C2=A0=C2=A0=C2=A0 super(QEMUQtestMachine,
>>>> self)._pre_launch()
>>>> 01:24:06 DEBUG| [stdout] +=C2=A0 File
>>>> "/home/jenkins/ppc64le/qemu-master/tests/qemu-iotests/../../python/qem=
u/machine.py",
>>>> line 270, in _pre_launch
>>>> 01:24:06 DEBUG| [stdout] +=C2=A0=C2=A0=C2=A0 self._qmp =3D
>>>> qmp.QEMUMonitorProtocol(self._vm_monitor, server=3DTrue)
>>>> 01:24:06 DEBUG| [stdout] +=C2=A0 File
>>>> "/home/jenkins/ppc64le/qemu-master/tests/qemu-iotests/../../python/qem=
u/qmp.py",
>>>> line 60, in __init__
>>>> 01:24:06 DEBUG| [stdout] +=C2=A0=C2=A0=C2=A0 self.__sock.bind(self.__a=
ddress)
>>>> 01:24:06 DEBUG| [stdout] +OSError: [Errno 98] Address already in use
>>
>> Was this test 147?=C2=A0 If so, see:
>> https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg01469.html
>>
>> because that failure matches what I was seeing.
>>
>>>>
>>>> I made the mistake of reproducing this on my home system using the
>>>> qemu revision that I had and assuming it's caused by a used port. So
>>>> I limited the port range and used nc to occupy the port. It sort-of
>>>> reproduced but instead of Address already in use it hanged until I
>>>> kill the nc process. Then it failed with:
>>>>
>>>> +Traceback (most recent call last):
>>>> +=C2=A0 File "147", line 124, in test_inet
>>>> +=C2=A0=C2=A0=C2=A0 flatten_sock_addr(address))
>>>> +=C2=A0 File "147", line 59, in client_test
>>>> +=C2=A0=C2=A0=C2=A0 self.assert_qmp(result, 'return', {})
>>>> +=C2=A0 File
>>>> "/home/medic/Work/Projekty/qemu/tests/qemu-iotests/iotests.py", line
>>>> 821, in assert_qmp
>>>> +=C2=A0=C2=A0=C2=A0 result =3D self.dictpath(d, path)
>>>> +=C2=A0 File
>>>> "/home/medic/Work/Projekty/qemu/tests/qemu-iotests/iotests.py", line
>>>> 797, in dictpath
>>>> +=C2=A0=C2=A0=C2=A0 self.fail('failed path traversal for "%s" in "%s"'=
 % (path,
>>>> str(d)))
>>>> +AssertionError: failed path traversal for "return" in "{'error':
>>>> {'class': 'GenericError', 'desc': 'Failed to read initial magic:
>>>> Unexpected end-of-file before all bytes were read'}}"
>>>>
>>
>> That's a secondary failure, I assume if the initial bug is fixed we are
>> less likely to hit the secondary one; but the secondary one may still be
>> worth fixing.
>>
>>>> After a brief study I thought qemu is not doing the job well enough
>>>> and wanted to add a protection. Anyway after a more thorough overview
>>>> I came to a different conclusion and that is that we are facing the
>>>> same issue as with incoming migration about a year ago. What happened
>>>> is that I started "nc -l localhost 32789" which results in:
>>>>
>>>> COMMAND=C2=A0=C2=A0 PID=C2=A0 USER=C2=A0=C2=A0 FD=C2=A0=C2=A0 TYPE=C2=
=A0 DEVICE SIZE/OFF NODE NAME
>>>> nc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26758 medic=C2=A0=C2=A0=C2=A0 3u=C2=
=A0 IPv6 9579487=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0t0=C2=A0 TCP localhost:3278=
9
>>>> (LISTEN)
>>>>
>>>> Then we start the server by "_try_server_up" where qemu-nbd detects
>>>> the port is occupied on IPv6 but available on IPv4, so it claims it:
>>>> COMMAND=C2=A0=C2=A0 PID=C2=A0 USER=C2=A0=C2=A0 FD=C2=A0=C2=A0 TYPE=C2=
=A0 DEVICE SIZE/OFF NODE NAME
>>>> nc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 26758 medic=C2=A0=C2=A0=
=C2=A0 3u=C2=A0 IPv6 9579487=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0t0=C2=A0 TCP
>>>> localhost:32789 (LISTEN)
>>>> qemu-nbd=C2=A0 26927 medic=C2=A0=C2=A0=C2=A0 4u=C2=A0 IPv4 9591857=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 0t0=C2=A0 TCP
>>>> localhost:32789 (LISTEN)
>>>>
>>>> and reports success. Then we try to connect but the hotplugged VM
>>>> first attempts to connect on the IPv6 address and hangs for infinity.
>>>>
>>>> Now is this an expected behavior? If so then we need the
>>>> find_free_address (but preferably directly in _try_server_up just
>>>> before starting the qemu-nbd) to leave as little time-frame for
>>>> collision as possible. Otherwise the test is alright and qemu-nbd
>>>> needs a fix to bail out in case some address is already used (IIRC
>>>> this is what incoming migration does).
>>>
>>> Ah, OK.
>>>
>>> Well, expected behavior...=C2=A0 It=E2=80=99s a shame, that=E2=80=99s w=
hat it is.
>>
>> In libnbd, we recently improved the testsuite by switching over to
>> systemd-style fd passing: instead of asking qemu-nbd to open a random
>> port (and hoping it is available), we instead pre-open the port (where
>> failure is under our control) and then pass in that fd with environment
>> variables to qemu-nbd, which in turn guarantees that qemu-nbd won't hit
>> failures in trying to use the port.=C2=A0 Maybe we should utilize that m=
ore
>> in qemu's own testsuite.
>=20
> I suppose you=E2=80=99re welcome, but it sounds a bit like overkill for n=
ow. :-)
>=20

Still you need to test all the variants...

>> Also, I need to revisit my proposed patches for letting qemu-nbd support
>> TLS over Unix sockets, as that's another way to avoid TCP contention
>> (right now, qemu has an anachronistic prohibition against the
>> combination of TLS and Unix sockets).
>=20
> 147 specifically wants to test inet, though (among other things).
> Support for TLS over Unix sockets won=E2=80=99t change that.  (I suppose =
it will
> reduce the number of inet NBD sockets in other tests, though.)
>=20
>>>> My second mistake was testing this on the old code-base and rebasing
>>>> it only before sending the patch (without testing after the rebase).
>>>> If I were to test it first, I would have found out that the real
>>>> reproducer is simply running the test as the commit
>>>> 8dff69b9415b4287e900358744b732195e1ab2e2 broke it.
>>>>
>>>>
>>>> So basically there are 2 actions:
>>>>
>>>> 1. fix the test as on my system it fails in 100% of cases, bisect
>>>> says the first bad commit is
>>>> 8dff69b9415b4287e900358744b732195e1ab2e2. Would anyone have time in
>>>> digging into this? I already spent way too much time on this and
>>>> don't really know what that commit is trying to do.
>>>
>>> Yep, I=E2=80=99ve sent a patch:
>>>
>>> https://lists.nongnu.org/archive/html/qemu-block/2020-02/msg00294.html
>>

Thank you :-)

>> Ah, so we did notice the same problem.
>>
>>>
>>>> 2. decide on the behavior when IPv4/6 is already in use (bail-out or
>>>> start).
>>>> 2a. In case it should bail-out than the test is correct and there is
>>>> no need for my patch. On the other hand qemu-nbd has to be fixed
>>>
>>> I don=E2=80=99t think it makes much sense to let qemu=E2=80=99s NBD ser=
ver ensure that
>>> it claims both IPv4 and IPv6 in case the user specifies a
>>> non-descriptive hostname.
>>>
>>>> 2b. Otherwise I can send a v2 that will check the port in the
>>>> _try_server_up just before starting qemu-nbd to minimize the risk of
>>>> using a utilized port (or should you decide it's not worth checking,
>>>> I can simply forget about this)
>>>
>>> Hm.=C2=A0 It wouldn=E2=80=99t be fully reliable, but, well...=C2=A0 The=
 risk would be
>>> minimal.
>>>
>>> OTOH, would it work if we just did a %s/localhost/127.0.0.1/ in the
>>> test?=C2=A0 We have specific cases for IPv6, so I think it makes sense =
to
>>> force IPv4 in all other cases.
>>
>> Except then it will fail on machines configured for IPv6-only.
>=20
> So we=E2=80=99ll just have to test whether IPv4 works, just like we alrea=
dy do
> for IPv6, no?
>=20

Sure, using ::1 for IPv6 and 127.0.0.1 for IPv4 cases would work. The quest=
ion is whether the behavior is really expected. In migration it was conside=
red dangerous, because you can have 2 VMs starting the migration at the sam=
e time. They both might attempt to get the same port, one would receive IPv=
4 the other IPv6. Then depending on the order of start migrate you might en=
d-up attempting to migrate the other VMs instead of the intended ones.

The same can happen here, you might start 2 nbd exports at the same time, g=
et the same port without any failures and then depending on luck get the ri=
ght or wrong export when attempting to connect. So I think bailing out in c=
ase we fail to get all interfaces would be the most appropriate (note the s=
ame situation is for 0.0.0.0 where you might end-up serving multiple differ=
ent disks on different interfaces). Anyway I leave it to you. If you decide=
 you don't want to fail than using ::1/127.0.0.1 sounds like a good idea. O=
therwise it'd make sense to create a test that especially uses ::1 and then=
 localhost to make sure it bails-out.

Regards,
Luk=C3=A1=C5=A1

> Max
>=20



--2Mqm5OAHAeTCVwglMdrmK4a2JXOGQEkPN--

--EcXrAFfVir2gw809V9BQY7uu1Zj9JbOgt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEFAl48W/oACgkQJrNi5H/P
IsGzIQf8CRJyJ4qKc6bU48wsZm+RcXJNDkFAYjfmfRjIy6O8DliIEzf8QoyHH+bh
PLqXlTy52OI29IRCN6Bqf5e48u2Ea72xxOdGp0HMzsP9g/3nd/LR1hsRwEGOBaFc
CW/etKGtF6UElXSKi6Fc03sLaGgGb2dOVMdV5m4OmiXu+oE5eFiF1g4mL0tgPd3J
9jEtNoL1WCnDmSTAlOnAR3CiJRtacS9bXLZnej9pa7KMmvxSga1w3FYfNm6P2GQI
ezWtoSAYywhlfp/or6i+pGmEVVgAHJdcSD5Tn6e3AF8Ap2+tv8I5Ykvhc/ptSvOI
nW+FpLqx3L7TLkSiwfQbhb9TKTmm0g==
=Qfrn
-----END PGP SIGNATURE-----

--EcXrAFfVir2gw809V9BQY7uu1Zj9JbOgt--


