Received: from eggs.gnu.org ([2001:4830:134:3::10]:52305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ew7jX-00011R-KR
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 10:50:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ew7jS-0007J2-P1
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 10:50:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46118 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ew7jS-0007Hw-Ky
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 10:50:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A9078182D11
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 14:50:22 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180307114013.GM20201@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
	=?utf-8?Q?rang=C3=A9=22's?=
	message of "Wed, 7 Mar 2018 11:40:13 +0000")
References: <20180307110010.2205-1-quintela@redhat.com>
	<20180307110010.2205-5-quintela@redhat.com>
	<20180307114013.GM20201@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 14 Mar 2018 15:51:11 +0100
Message-ID: <87zi3asobk.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v10 04/24] migration: Set the migration tcp
 port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Daniel P. Berrange <berrange@redhat.com> wrote:
> On Wed, Mar 07, 2018 at 11:59:50AM +0100, Juan Quintela wrote:
>> We can set the port parameter as zero.  This patch lets us know what
>> port the system was choosen for us.  Now we can migrate to this place.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>

>> +void migrate_set_port(const uint16_t port, Error **errp)
>> +{
>> +    MigrateSetParameters p = {
>> +        .has_x_tcp_port = true,
>> +        .x_tcp_port = port,
>> +    };
>> +
>> +    qmp_migrate_set_parameters(&p, errp);
>> +}
>
> This is really not nice - it is requiring the QMP  'migrate-set-parameters'
> command to accept an extra field that is never something we want the end
> user to be allowed to set. We should not use the public QMP schema for
> data items we are just passing between 2 internal pieces of code.

void migrate_set_address(SocketAddress *address)
{
    MigrationState *s = migrate_get_current();

    s->parameters.has_x_socket_address = true;
    s->parameters.x_socket_address = address;
}


I hope that is ok with you O:-)

Later, Juan.

PD.  Yes, I agree about not using QMP inside two pieces of code, but on
     the other hand, it make this so *future* proof O:-)
