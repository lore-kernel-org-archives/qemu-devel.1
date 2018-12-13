Received: from eggs.gnu.org ([2001:4830:134:3::10]:57807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXTBY-0007I4-A5
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 10:46:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXTBW-0004ao-QH
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 10:46:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXTBW-0004ZG-Bu
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 10:45:58 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 793FF30842CE
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 15:45:57 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181213123724.4866-1-marcandre.lureau@redhat.com>
	<20181213123724.4866-15-marcandre.lureau@redhat.com>
	<87h8fhr1nl.fsf@dusky.pond.sub.org>
Date: Thu, 13 Dec 2018 16:45:51 +0100
In-Reply-To: <87h8fhr1nl.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Thu, 13 Dec 2018 14:34:22 +0100")
Message-ID: <87a7l9o2fk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 14/22] qapi: add an error in case a
 discriminator is conditional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Markus Armbruster <armbru@redhat.com> writes:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> Making a discriminator conditional doesn't make much sense.  "qapi:

I guess it could be made to work as long as the discriminator's
condition implies each variant's condition.  Example:

    { 'union': 'BlockdevQcow2Encryption',
      'base': {
          'format': { 'type': 'BlockdevQcow2EncryptionFormat',
                      'if': 'defined(CONFIG_AES) || defined(CONFIG_LUKS)' }=
 },
      'discriminator': 'format',
      'data': {
          'aes': { 'type': 'QCryptoBlockOptionsQCow',
                   'if': 'defined(CONFIG_AES)' },
          'luks': 'type': 'QCryptoBlockOptionsLUKS',
                  'if': 'defined(CONFIG_LUKS)' } }

Now, this example looks like a bad idea.  Whether there's a more
legitimate use remains to be seen.  Until then, outlawing conditional
discriminators is totally fine with me.

>> add a dictionary form for TYPE" allows it, this patch fixes
>> it. Eventually the two could be merged, but for clarity of review it
>> is kept separate.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> I may accept the offer to let me squash it into the previous patch when
> I apply.

Squashed patch's commit message:

    qapi: Add 'if' to implicit struct members

    The generated code is for now *unconditional*.  Later patches generate
    the conditionals.

    Note that union discriminators may not have 'if' conditionals.

Avoids passing judgement :)
