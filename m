Received: from eggs.gnu.org ([2001:4830:134:3::10]:47371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fYWZJ-0007Ck-Vp
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:02:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fYWZE-0001oV-5E
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:02:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35676 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fYWZE-0001o3-0l
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:02:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 45A7C8151D6F
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:02:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180620073223.31964-1-peterx@redhat.com>
	<871sctea4y.fsf@dusky.pond.sub.org>
	<87tvpoadcc.fsf_-_@dusky.pond.sub.org>
	<87wouk8vul.fsf@dusky.pond.sub.org>
	<87h8lo74oa.fsf@dusky.pond.sub.org>
	<20180627132853.GO30628@redhat.com>
Date: Thu, 28 Jun 2018 15:02:27 +0200
In-Reply-To: <20180627132853.GO30628@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
	=?utf-8?Q?rang=C3=A9=22's?=
	message of "Wed, 27 Jun 2018 14:28:53 +0100")
Message-ID: <8736x7hxng.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] monitor: enable OOB by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Jun 27, 2018 at 03:13:57PM +0200, Markus Armbruster wrote:
>> Monitor behavior changes even when the client rejects capability "oob".
>>=20
>> Traditionally, the monitor reads, executes and responds to one command
>> after the other.  If the client sends in-band commands faster than the
>> server can execute them, the kernel will eventually refuse to buffer
>> more, and sending blocks or fails with EAGAIN.
>>=20
>> To make OOB possible, we need to read and queue commands as we receive
>> them.  If the client sends in-band commands faster than the server can
>> execute them, the server will eventually drop commands to limit the
>> queue length.  The sever sends event COMMAND_DROPPED then.
>>=20
>> However, we get the new behavior even when the client rejects capability
>> "oob".  We get the traditional behavior only when the server doesn't
>> offer "oob".
>>=20
>> Is this what we want?
>
> IMHO the key benefit of allowing the client to reject the capability
> is to enable backwards compat support. So this behaviour feels wrong.
> Rejecting OOB should have same semantics as previous QEMU's without
> OOB available, otherwise we now have 3 distinct ways the monitor
> operates  (no OOB, OOB rejected, OOB accepted). This can only ever
> lead to more bugs due to lack of testing of no OOB vs OOB rejected
> scenarios.

Agreed.

We have three configuration cases

* OOB not offered (because MUX)

* OOB offered, but rejected by client

* OOB offered and accepted

We want to map them to two run time cases

* OOB off

* OOB on

We may use "server offered OOB" only for configuration purposes.

Keep that in mind when reading my reply to Peter's reply.

Aside: it would be nice to get rid of the configuration case "OOB not
offered", but that's for later.
