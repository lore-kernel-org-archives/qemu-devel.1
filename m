Received: from eggs.gnu.org ([2001:4830:134:3::10]:35189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1f4UsF-0006gI-GT
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:10:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1f4UsA-0004n1-DL
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:10:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35120 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1f4UsA-0004bX-90
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:09:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9B03940006E6
	for <qemu-devel@nongnu.org>; Fri,  6 Apr 2018 17:09:41 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180316175719.GF3066@redhat.com> ("Daniel P. =?utf-8?Q?Berr?=
	=?utf-8?Q?ang=C3=A9=22's?=
	message of "Fri, 16 Mar 2018 17:57:19 +0000")
References: <20180316115403.4148-1-quintela@redhat.com>
	<20180316115403.4148-2-quintela@redhat.com>
	<20180316174907.GZ3066@redhat.com> <20180316175719.GF3066@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 06 Apr 2018 19:10:58 +0200
Message-ID: <876054ntul.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 01/15] migration: Set error state in
 case of error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com

Daniel P. Berrange <berrange@redhat.com> wrote:
> On Fri, Mar 16, 2018 at 05:49:07PM +0000, Daniel P. Berrang=C3=A9 wrote:
>> On Fri, Mar 16, 2018 at 12:53:49PM +0100, Juan Quintela wrote:
>> > Signed-off-by: Juan Quintela <quintela@redhat.com>
>> > ---
>> >  migration/ram.c | 20 ++++++++++++++++++++
>> >  1 file changed, 20 insertions(+)
>> >=20
>> > diff --git a/migration/ram.c b/migration/ram.c
>> > index 7266351fd0..1b8095a358 100644
>> > --- a/migration/ram.c
>> > +++ b/migration/ram.c
>> > @@ -414,6 +414,16 @@ static void terminate_multifd_send_threads(Error =
*errp)
>> >  {
>> >      int i;
>> >=20=20
>> > +    if (errp) {
>> > +        MigrationState *s =3D migrate_get_current();
>> > +        migrate_set_error(s, errp);
>>=20
>> This doesn't look quiet right. You're checking if 'errp' is a non-NULL,
>> which just tells you if the caller wants to collect the error, not
>> whether an error has happened. For the latter you need
>>=20
>>   if (errp && *errp)
>>=20
>> seems a little strange though for the caller to pass an error into this
>> method for reporting.
>
> Oh wait, I'm being mislead by the unusual parameter name.
>
> An "errp" name should only ever be used for a "Error **", but we
> only have an "Error *" here.

Copy & Paste O:-)

> So just fix the parameter name to be "err" instead of "errp".

Done.

Thanks,
