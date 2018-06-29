Received: from eggs.gnu.org ([2001:4830:134:3::10]:53118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYqQu-0004QW-Mo
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:15:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYqQr-0002y2-FG
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:15:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41964 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fYqQr-0002xb-AN
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:15:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA4618182D1F
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 10:15:12 +0000 (UTC)
References: <1530215858-1525-1-git-send-email-pbonzini@redhat.com>
	<1530215858-1525-7-git-send-email-pbonzini@redhat.com>
	<67ddeac6-c110-5969-e6fb-847a773aa2d8@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <87c8a1bf-9245-f8ac-4084-c39e19a29ae1@redhat.com>
Date: Fri, 29 Jun 2018 12:15:11 +0200
MIME-Version: 1.0
In-Reply-To: <67ddeac6-c110-5969-e6fb-847a773aa2d8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/6] pr-manager-helper: report event on
 connection/disconnection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

On 28/06/2018 22:24, Eric Blake wrote:
> On 06/28/2018 02:57 PM, Paolo Bonzini wrote:
>> Let management know if there were any problems communicating with
>> qemu-pr-helper.=C2=A0 The event is edge-triggered, and is sent every t=
ime
>> the connection status of the pr-manager-helper object changes.
>=20
> Is this something that guest actions can intentionally trigger, and thu=
s
> cause a DoS attack by flooding the management app with events faster
> than they can process?

No, unless they find a way to crash qemu-pr-helper and libvirt
immediately restarts it.  If anything libvirt could throttle the restart
of the process, or ultimately not restart it at all, but I don't think
it's necessary.

Paolo

>=C2=A0 If so, this event should use rate-limiting.
>=20
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>> =C2=A0 qapi/block.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 24 ++++++++++++++++++++++++
>> =C2=A0 scsi/pr-manager-helper.c | 14 ++++++++++++++
>> =C2=A0 2 files changed, 38 insertions(+)
>=20
