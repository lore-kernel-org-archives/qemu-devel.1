Received: from eggs.gnu.org ([2001:4830:134:3::10]:40014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cRBh7-0000ae-OA
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 00:43:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cRBh6-0001GU-Qo
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 00:43:33 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:33728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1cRBh6-0001Fv-Lv
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 00:43:32 -0500
Received: by mail-oi0-x241.google.com with SMTP id j15so20309526oih.0
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 21:43:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_jcWo+mJ=3FLgx_R7QEvZ9NeTp-RhYZF4nczY-FViySg@mail.gmail.com>
References: <1483981368-9965-1-git-send-email-ashijeetacharya@gmail.com>
	<1483981368-9965-5-git-send-email-ashijeetacharya@gmail.com>
	<CAFEAcA_jcWo+mJ=3FLgx_R7QEvZ9NeTp-RhYZF4nczY-FViySg@mail.gmail.com>
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Wed, 11 Jan 2017 11:13:31 +0530
Message-ID: <CAC2QTZb4cUasLDc6GbkLd18rxzkceehE9ojocrRHW4--JNeQFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v4 4/4] migration: Fail migration blocker
 for --only-migratble
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, John Snow <jsnow@redhat.com>, Amit Shah <amit.shah@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, Jan 10, 2017 at 10:45 PM, Peter Maydell
<peter.maydell@linaro.org> wrote:
> On 9 January 2017 at 17:02, Ashijeet Acharya <ashijeetacharya@gmail.com> wrote:
>> migrate_add_blocker should rightly fail if the '--only-migratable'
>> option was specified and the device in use should not be able to
>> perform the action which results in an unmigratable VM.
>>
>> Make migrate_add_blocker return -EACCES in this case.
>
>> diff --git a/block/qcow.c b/block/qcow.c
>> index 11526a1..bdc6446 100644
>> --- a/block/qcow.c
>> +++ b/block/qcow.c
>> @@ -254,7 +254,10 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
>>                 bdrv_get_device_or_node_name(bs));
>>      ret = migrate_add_blocker(s->migration_blocker, errp);
>>      if (ret < 0) {
>> -        error_free(s->migration_blocker);
>> +        if (ret == -EACCES) {
>> +            error_append_hint(errp, "Cannot use a node with qcow format as "
>> +                              "it does not support live migration");
>> +        }
>>          goto fail;
>>      }
>>
>
> The error handling for these call sites should look just like
> that for any other function call that takes an Error**:
>
>     Error *local_err = NULL;
>     [...]
>     migrate_add_blocker(s->migration_blocker, &local_err);
>     if (local_err) {
>         error_propagate(errp, local_err);
>         return; // or otherwise handle failure appropriately
>     }
>

I think it will be better to make migrate_add_blocker() to return the
error value as well, otherwise we will end up setting ret in all the
callers manually and that will lead to a repetition of code at all
call sites, right? Refer to qcow for an example...

> migrate_add_blocker() should just internally construct
> the error text and extra hint lines by looking at the
> text it can fish out of the s->migration_blocker argument
> and calling error_append_hint() itself.
>
Yes, I have done that now.

> The patch is also a bit odd because the error_free() calls
> were only added in patch 3/4, right? Generally adding
> lines of code in one patch and deleting them in the next
> is a bad idea.

Yes, I have removed that as well.

Ashijeet
>
> thanks
> -- PMM
