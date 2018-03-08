Received: from eggs.gnu.org ([2001:4830:134:3::10]:41509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1etlTA-0002n3-Cv
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 21:39:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1etlT6-0003qc-Ng
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 21:39:47 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42480 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1etlT6-0003qJ-IN
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 21:39:44 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 75B098182D1E
	for <qemu-devel@nongnu.org>; Thu,  8 Mar 2018 02:39:33 +0000 (UTC)
References: <20180307110010.2205-1-quintela@redhat.com>
	<20180307110010.2205-11-quintela@redhat.com>
	<20180307115210.GN20201@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <96cd3e2a-d05a-e9e5-ac2c-c50ad9432924@redhat.com>
Date: Wed, 7 Mar 2018 20:39:28 -0600
MIME-Version: 1.0
In-Reply-To: <20180307115210.GN20201@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v10 10/24] migration: In case of error just
 end the migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com

On 03/07/2018 05:52 AM, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Mar 07, 2018 at 11:59:56AM +0100, Juan Quintela wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>   migration/socket.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20

> It will only return NULL if a client connected & then went away. This s=
hould
> not happen with a "normal" mgmt app usage. On the flip side this allows=
 a
> malicious network attacker to inflict a denial of service on the migrat=
ion
> by simply connecting to target QEMU & immediately exiting.
>=20
> Our "authentication" for migration relies on being able to validate the=
 TLS
> certs during TLS handshake. So in general we ought to allow repeated in=
coming
> connections until we get a successful handshake.

Indeed, our NBD code had some CVE fixes last year where a rogue 'nc'=20
process could cause denial of service by connecting and hanging up=20
immediately, until we fixed it to retry until the first client that=20
actually got past the handshake.  We don't need to repeat CVEs like that.

>=20
> So in fact, I think a better fix here is to simply remove the original
> 'error_report' line, and ensure we return G_SOURCE_CONTINUE to wait for
> another incoming connection from the real mgmt app.
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
