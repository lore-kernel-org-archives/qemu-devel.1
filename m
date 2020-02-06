Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1228EC33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:50:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCE3A20838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i21k2Zse"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE3A20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izkM1-0001Q0-Sn
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 11:50:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56558)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1izkL1-00083K-V8
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:49:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1izkL0-0007Tg-20
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:49:11 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35011
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1izkKz-0007R9-Uh
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:49:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581007749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nA0Z9XQdZkLoyMP7+S643kyEMtY3XTB4WmhULCLjqkM=;
 b=i21k2Zserw/bEkk9R/zevCmSK79oxDIkPvd76XBjEvwPABcBxMEVV1kOSa/X96VveEb0Ey
 ZE/mEYwsAqBODDMH+GSjrnXtoX/8lQvH/VojgJ+FrGZ1nHOPliAkc0Kn7XvUD0euw62sMw
 WFE47oYjXiuDLxuL1YvvZNlvdYLV+Lk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-Y47xCJDPNQa2ffI0oCmwNw-1; Thu, 06 Feb 2020 11:48:31 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D4B7802B9E;
 Thu,  6 Feb 2020 16:48:30 +0000 (UTC)
Received: from [10.3.117.249] (ovpn-117-249.phx2.redhat.com [10.3.117.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2029B60BEC;
 Thu,  6 Feb 2020 16:48:27 +0000 (UTC)
Subject: Re: [PATCH] tests/qemu_iotests: Minimize usage of used ports
To: Max Reitz <mreitz@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?=
 <ldoktor@redhat.com>, qemu-block@nongnu.org
References: <20200203075955.28861-1-ldoktor@redhat.com>
 <fe6a7eb5-352a-3cb5-4e75-bd99baf6d54e@redhat.com>
 <595ffedf-4213-f000-96e1-3216e272b1c1@redhat.com>
 <726ca911-be83-c2d5-ff3f-efa32bc2233e@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <797578d5-bfab-5eb7-8921-0fcf1f3ee40e@redhat.com>
Date: Thu, 6 Feb 2020 10:48:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <726ca911-be83-c2d5-ff3f-efa32bc2233e@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Y47xCJDPNQa2ffI0oCmwNw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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

On 2/6/20 10:37 AM, Max Reitz wrote:

>>
>> thank you and I am sorry for not digging deep enough. This week my CI fa=
iled with:
>>
>> 01:24:06 DEBUG| [stdout] +ERROR: test_inet (__main__.QemuNBD)
>> 01:24:06 DEBUG| [stdout] +----------------------------------------------=
------------------------
>> 01:24:06 DEBUG| [stdout] +Traceback (most recent call last):
>> 01:24:06 DEBUG| [stdout] +  File "147", line 85, in setUp
>> 01:24:06 DEBUG| [stdout] +    self.vm.launch()
>> 01:24:06 DEBUG| [stdout] +  File "/home/jenkins/ppc64le/qemu-master/test=
s/qemu-iotests/../../python/qemu/machine.py", line 302, in launch
>> 01:24:06 DEBUG| [stdout] +    self._launch()
>> 01:24:06 DEBUG| [stdout] +  File "/home/jenkins/ppc64le/qemu-master/test=
s/qemu-iotests/../../python/qemu/machine.py", line 319, in _launch
>> 01:24:06 DEBUG| [stdout] +    self._pre_launch()
>> 01:24:06 DEBUG| [stdout] +  File "/home/jenkins/ppc64le/qemu-master/test=
s/qemu-iotests/../../python/qemu/qtest.py", line 106, in _pre_launch
>> 01:24:06 DEBUG| [stdout] +    super(QEMUQtestMachine, self)._pre_launch(=
)
>> 01:24:06 DEBUG| [stdout] +  File "/home/jenkins/ppc64le/qemu-master/test=
s/qemu-iotests/../../python/qemu/machine.py", line 270, in _pre_launch
>> 01:24:06 DEBUG| [stdout] +    self._qmp =3D qmp.QEMUMonitorProtocol(self=
._vm_monitor, server=3DTrue)
>> 01:24:06 DEBUG| [stdout] +  File "/home/jenkins/ppc64le/qemu-master/test=
s/qemu-iotests/../../python/qemu/qmp.py", line 60, in __init__
>> 01:24:06 DEBUG| [stdout] +    self.__sock.bind(self.__address)
>> 01:24:06 DEBUG| [stdout] +OSError: [Errno 98] Address already in use

Was this test 147?  If so, see:
https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg01469.html

because that failure matches what I was seeing.

>>
>> I made the mistake of reproducing this on my home system using the qemu =
revision that I had and assuming it's caused by a used port. So I limited t=
he port range and used nc to occupy the port. It sort-of reproduced but ins=
tead of Address already in use it hanged until I kill the nc process. Then =
it failed with:
>>
>> +Traceback (most recent call last):
>> +  File "147", line 124, in test_inet
>> +    flatten_sock_addr(address))
>> +  File "147", line 59, in client_test
>> +    self.assert_qmp(result, 'return', {})
>> +  File "/home/medic/Work/Projekty/qemu/tests/qemu-iotests/iotests.py", =
line 821, in assert_qmp
>> +    result =3D self.dictpath(d, path)
>> +  File "/home/medic/Work/Projekty/qemu/tests/qemu-iotests/iotests.py", =
line 797, in dictpath
>> +    self.fail('failed path traversal for "%s" in "%s"' % (path, str(d))=
)
>> +AssertionError: failed path traversal for "return" in "{'error': {'clas=
s': 'GenericError', 'desc': 'Failed to read initial magic: Unexpected end-o=
f-file before all bytes were read'}}"
>>

That's a secondary failure, I assume if the initial bug is fixed we are=20
less likely to hit the secondary one; but the secondary one may still be=20
worth fixing.

>> After a brief study I thought qemu is not doing the job well enough and =
wanted to add a protection. Anyway after a more thorough overview I came to=
 a different conclusion and that is that we are facing the same issue as wi=
th incoming migration about a year ago. What happened is that I started "nc=
 -l localhost 32789" which results in:
>>
>> COMMAND   PID  USER   FD   TYPE  DEVICE SIZE/OFF NODE NAME
>> nc      26758 medic    3u  IPv6 9579487      0t0  TCP localhost:32789 (L=
ISTEN)
>>
>> Then we start the server by "_try_server_up" where qemu-nbd detects the =
port is occupied on IPv6 but available on IPv4, so it claims it:
>> COMMAND   PID  USER   FD   TYPE  DEVICE SIZE/OFF NODE NAME
>> nc        26758 medic    3u  IPv6 9579487      0t0  TCP localhost:32789 =
(LISTEN)
>> qemu-nbd  26927 medic    4u  IPv4 9591857      0t0  TCP localhost:32789 =
(LISTEN)
>>
>> and reports success. Then we try to connect but the hotplugged VM first =
attempts to connect on the IPv6 address and hangs for infinity.
>>
>> Now is this an expected behavior? If so then we need the find_free_addre=
ss (but preferably directly in _try_server_up just before starting the qemu=
-nbd) to leave as little time-frame for collision as possible. Otherwise th=
e test is alright and qemu-nbd needs a fix to bail out in case some address=
 is already used (IIRC this is what incoming migration does).
>=20
> Ah, OK.
>=20
> Well, expected behavior...  It=E2=80=99s a shame, that=E2=80=99s what it =
is.

In libnbd, we recently improved the testsuite by switching over to=20
systemd-style fd passing: instead of asking qemu-nbd to open a random=20
port (and hoping it is available), we instead pre-open the port (where=20
failure is under our control) and then pass in that fd with environment=20
variables to qemu-nbd, which in turn guarantees that qemu-nbd won't hit=20
failures in trying to use the port.  Maybe we should utilize that more=20
in qemu's own testsuite.

Also, I need to revisit my proposed patches for letting qemu-nbd support=20
TLS over Unix sockets, as that's another way to avoid TCP contention=20
(right now, qemu has an anachronistic prohibition against the=20
combination of TLS and Unix sockets).

>=20
>> My second mistake was testing this on the old code-base and rebasing it =
only before sending the patch (without testing after the rebase). If I were=
 to test it first, I would have found out that the real reproducer is simpl=
y running the test as the commit 8dff69b9415b4287e900358744b732195e1ab2e2 b=
roke it.
>>
>>
>> So basically there are 2 actions:
>>
>> 1. fix the test as on my system it fails in 100% of cases, bisect says t=
he first bad commit is 8dff69b9415b4287e900358744b732195e1ab2e2. Would anyo=
ne have time in digging into this? I already spent way too much time on thi=
s and don't really know what that commit is trying to do.
>=20
> Yep, I=E2=80=99ve sent a patch:
>=20
> https://lists.nongnu.org/archive/html/qemu-block/2020-02/msg00294.html

Ah, so we did notice the same problem.

>=20
>> 2. decide on the behavior when IPv4/6 is already in use (bail-out or sta=
rt).
>> 2a. In case it should bail-out than the test is correct and there is no =
need for my patch. On the other hand qemu-nbd has to be fixed
>=20
> I don=E2=80=99t think it makes much sense to let qemu=E2=80=99s NBD serve=
r ensure that
> it claims both IPv4 and IPv6 in case the user specifies a
> non-descriptive hostname.
>=20
>> 2b. Otherwise I can send a v2 that will check the port in the _try_serve=
r_up just before starting qemu-nbd to minimize the risk of using a utilized=
 port (or should you decide it's not worth checking, I can simply forget ab=
out this)
>=20
> Hm.  It wouldn=E2=80=99t be fully reliable, but, well...  The risk would =
be minimal.
>=20
> OTOH, would it work if we just did a %s/localhost/127.0.0.1/ in the
> test?  We have specific cases for IPv6, so I think it makes sense to
> force IPv4 in all other cases.

Except then it will fail on machines configured for IPv6-only.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


