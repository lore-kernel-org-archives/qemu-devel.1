Received: from eggs.gnu.org ([2001:4830:134:3::10]:55955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cYEyQ-000134-M6
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 11:38:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cYEyN-0003wf-HR
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 11:38:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cYEyN-0003wR-Bl
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 11:38:31 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <CAFEAcA_tGGVL2aP5Gu5ZyX3KKVTA_gFa4wtSxAhJrjAKQZiOLw@mail.gmail.com>
	(Peter Maydell's message of "Mon, 30 Jan 2017 15:09:52 +0000")
References: <1485787271-8754-1-git-send-email-ashijeetacharya@gmail.com>
	<CAFEAcA_tGGVL2aP5Gu5ZyX3KKVTA_gFa4wtSxAhJrjAKQZiOLw@mail.gmail.com>
Reply-To: quintela@redhat.com
Date: Mon, 30 Jan 2017 17:38:28 +0100
Message-ID: <87a8a8ec57.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] migrate: Introduce a 'dc->vmsd' check to
 avoid segfault for --only-migratable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Ashijeet Acharya <ashijeetacharya@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Amit Shah <amit.shah@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> wrote:
> On 30 January 2017 at 14:41, Ashijeet Acharya <ashijeetacharya@gmail.com> wrote:
>> Commit a3a3d8c7 introduced a segfault bug while checking for
>> 'dc->vmsd->unmigratable' which caused QEMU to crash when trying to add
>> devices which do no set their 'dc->vmsd' yet while initialization.
>> Place a 'dc->vmsd' check prior to it so that we do not segfault for
>> such devices.
>>
>> NOTE: This doesn't compromise the functioning of --only-migratable
>> option as all the unmigratable devices do set their 'dc->vmsd'.
>>
>> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
>> ---
>>  qdev-monitor.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/qdev-monitor.c b/qdev-monitor.c
>> index 81d01df..a1106fd 100644
>> --- a/qdev-monitor.c
>> +++ b/qdev-monitor.c
>> @@ -578,7 +578,7 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
>>          return NULL;
>>      }
>>
>> -    if (only_migratable) {
>> +    if (only_migratable && dc->vmsd) {
>>          if (dc->vmsd->unmigratable) {
>>              error_setg(errp, "Device %s is not migratable, but "
>>                         "--only-migratable was specified", driver);
>
> This seems like a good fix for the crash as a short term fix,
> but longer term I think it would be better to make setting
> dc->vmsd mandatory. I think devices which don't set it fall into
> one of these categories:
>  * deliberately has no VMState struct as it has no state that
>    needs migrating -- we should have some kind of flag for
>    such devices to positively assert that they don't need to
>    deal with migration
>  * accidentally failed to provide a VMState struct -- this is
>    a bug and the device should be fixed to at minimum mark
>    itself as unmigratable (and ideally fixed to implement
>    migration!)
>  * didn't provide a VMState struct because they handle
>    migration manually using vmstate_register() -- we should
>    update these to use VMState, or failing that use the
>    flag to say "deliberately not providing VMState"
>
> Then we can make QEMU assert if dc->vmsd is NULL, and
> catch future occurrences of "oops I didn't think about
> migration" bugs in new device models. We also have an
> easy way to grep the codebase for devices that need to
> have migration implemented.

+1

Reviewed-by: Juan Quintela <quintela@redhat.com>
