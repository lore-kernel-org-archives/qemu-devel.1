Received: from eggs.gnu.org ([2001:4830:134:3::10]:49969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fWNYI-0003CK-Fk
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fWNYC-00038h-Of
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:00:42 -0400
References: <20180615142108.27814-1-kwolf@redhat.com>
	<20180615142108.27814-26-kwolf@redhat.com>
	<7a310b92-f8cb-b68b-d882-9b2959794347@de.ibm.com>
	<20180622125502.GF4366@localhost.localdomain>
	<8736xec39q.fsf@dusky.pond.sub.org> <20180622142519.GN23296@redhat.com>
	<20180622143034.GP23296@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <89b3a958-267b-53c2-93d6-86e94e392fdd@redhat.com>
Date: Fri, 22 Jun 2018 10:00:26 -0500
MIME-Version: 1.0
In-Reply-To: <20180622143034.GP23296@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] [PULL 25/26] block: Remove deprecated
 -drive option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>, qemu-block@nongnu.org, libvir-list@redhat.com, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, pkrempa@redhat.com

On 06/22/2018 09:30 AM, Daniel P. Berrang=C3=A9 wrote:
>>> Perhaps we could use a more structured notification, to make detectin=
g
>>> use of deprecated features programmatically trivial.  A QMP event mig=
ht
>>> do.
>>
>> Libvirt currently has CI that is largely focused on unit testing. We
>> recently did some work, however, to get our functional test suite
>> working properly again (Sys-Virt-TCK) and are trying to get some
>> new CI hardware. So if we get that running, we coud run tests on real
>> QEMU versions and check the /var/log/libvirt/qemu/$GUEST.logs to
>> make sure we're not triggering unexpected warnings from QEMU
>=20
> This could be even easier if there was a --no-deprecations flag to
> QEMU which triggered abort() whenever mgmt app uses a deprecated
> feature.

Yes, a QMP event (which libvirt could then turn into a hard error if it=20
ever receives the event) or a qemu command line option to make=20
deprecated usage fatal (which libvirt would choose to enable) would both=20
be pragmatic approaches to quickly vetting whether libvirt is using=20
something that qemu has marked deprecated - provided that we are careful=20
to always wire up the event/abort into qemu at each location where we=20
also add a deprecation message.  An event might be more flexible than=20
qemu aborting (as libvirt could make programmatic decisions on whether=20
to keep going in spite of the event, rather than the guest=20
unconditionally being lost).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
