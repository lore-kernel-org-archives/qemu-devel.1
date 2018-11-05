Received: from eggs.gnu.org ([2001:4830:134:3::10]:59190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gJh9s-0001yF-I5
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:51:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gJh9e-0000zB-To
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:51:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gJh9Z-0000o4-0q
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:51:02 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1541052594-29132-1-git-send-email-liq3ea@gmail.com>
	<20181105082622.yzxz3dis77knkpoa@sirius.home.kraxel.org>
Date: Mon, 05 Nov 2018 16:50:29 +0100
In-Reply-To: <20181105082622.yzxz3dis77knkpoa@sirius.home.kraxel.org> (Gerd
	Hoffmann's message of "Mon, 5 Nov 2018 09:26:22 +0100")
Message-ID: <87bm735xru.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] hw: fw_cfg: ensure reboot_time is
 nonegative
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Li Qiang <liq3ea@gmail.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, philmd@redhat.com, lersek@redhat.com

Gerd Hoffmann <kraxel@redhat.com> writes:

>> -    /* validate the input */
>> -    if (reboot_timeout > 0xffff) {
>> -        error_report("reboot timeout is larger than 65535, force it to 65535.");
>> -        reboot_timeout = 0xffff;
>> +
>> +    if (reboot_timeout >= 0) {
>> +        /* validate the input */
>> +        if (reboot_timeout > 0xffff) {
>> +            error_report("reboot timeout is larger than 65535,"
>> +                         "force it to 65535.");
>> +            reboot_timeout = 0xffff;
>> +        }
>> +        fw_cfg_add_file(s, "etc/boot-fail-wait",
>> +                        g_memdup(&reboot_timeout, 4), 4);
>>      }
>
> Hmm, values > 0xffff are reported and values < 0 are silently ignored.
> I think we should be consistent here.
> I'd suggest report and exit in both cases,

Agreed.  If the user specifies a value outside acceptable limits,
rejecting it is simpler than "correcting" it.  "Corrections" may look
convenient, but they're not worth the additional interface complexity.

> i.e. use error_setg(..., &error_fatal);

In case you mean something like

    error_setg(&error_fatal, "reboot timeout is larger than 65535");

I'd like to point to error.h:

 * Please don't error_setg(&error_fatal, ...), use error_report() and
 * exit(), because that's more obvious.
