Received: from eggs.gnu.org ([2001:4830:134:3::10]:56777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgCfF-0003ta-Mr
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:47:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgCfA-0006Gr-W3
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:47:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cgCfA-0006GF-MU
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:47:36 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170220160316.16803-1-danielhb@linux.vnet.ibm.com>
	<87ino3ncg5.fsf@dusky.pond.sub.org>
	<e9388bc4-2c50-0656-e140-b5478f35237b@linux.vnet.ibm.com>
	<87d1ebpr46.fsf@dusky.pond.sub.org> <20170221143222.GJ2377@work-vm>
Date: Tue, 21 Feb 2017 16:47:33 +0100
In-Reply-To: <20170221143222.GJ2377@work-vm> (David Alan Gilbert's message of
	"Tue, 21 Feb 2017 14:32:23 +0000")
Message-ID: <87k28j4kbu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] Changing error message of QMP
 'migrate_set_downtime' to seconds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org, quintela@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com> writes:
>> 
>> > On 02/21/2017 06:02 AM, Markus Armbruster wrote:
>> >> Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com> writes:
>> >>
>> >>> The previous error message was displaying the values in miliseconds,
>> >>> being misleading with the command that accepts the value in seconds:
>> >>>
>> >>> { "execute": "migrate_set_downtime", "arguments": {"value": 3000}}
>> >>> {"error": {"class": "GenericError", "desc": "Parameter 'downtime_limit'
>> >>> expects an integer in the range of 0 to 2000000 milliseconds"}}
>> >>>
>> >>> This patch changes it to '2000 seconds' to keep consistency with
>> >>> the expected parameter. The macro 'QERR_INVALID_PARAMETER_VALUE'
>> >>> was changed for a regular string that allows the use of the
>> >>> MAX_MIGRATE_SET_DOWNTIME as a parameter, instead of hardcoding
>> >>> the value in the error message.
>> >>>
>> >>> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
>> >>> ---
>> >>>   migration/migration.c | 12 ++++++++----
>> >>>   1 file changed, 8 insertions(+), 4 deletions(-)
>> >>>
>> >>> diff --git a/migration/migration.c b/migration/migration.c
>> >>> index c6ae69d..c05e764 100644
>> >>> --- a/migration/migration.c
>> >>> +++ b/migration/migration.c
>> >>> @@ -49,6 +49,9 @@
>> >>>    * for sending the last part */
>> >>>   #define DEFAULT_MIGRATE_SET_DOWNTIME 300
>> >>>   +/* Maximum migrate downtime set to 2000*1000 miliseconds */
>> >>> +#define MAX_MIGRATE_SET_DOWNTIME (2000 * 1000)
>> >>> +
>> >>>   /* Default compression thread count */
>> >>>   #define DEFAULT_MIGRATE_COMPRESS_THREAD_COUNT 8
>> >>>   /* Default decompression thread count, usually decompression is at
>> >>> @@ -843,10 +846,11 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>> >>>           return;
>> >>>       }
>> >>>       if (params->has_downtime_limit &&
>> >>> -        (params->downtime_limit < 0 || params->downtime_limit > 2000000)) {
>> >>> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
>> >>> -                   "downtime_limit",
>> >>> -                   "an integer in the range of 0 to 2000000 milliseconds");
>> >>> +        (params->downtime_limit < 0 ||
>> >>> +         params->downtime_limit > MAX_MIGRATE_SET_DOWNTIME)) {
>> >>> +        error_setg(errp, "Parameter 'downtime_limit' expects an integer in "
>> >>> +                         "the range of 0 to %d seconds",
>> >>> +                         MAX_MIGRATE_SET_DOWNTIME / 1000);
>> >>>           return;
>> >>>       }
>> >>>       if (params->has_x_checkpoint_delay && (params->x_checkpoint_delay < 0)) {
>> >> Isn't this wrong for QMP migrate-set-parameters?  There, the unit is
>> >> milliseconds, i.e. the new error message is as wrong as the old one is
>> >> for migrate_set_downtime.
>> >
>> > Actually the unit for migrate-set-parameters, as seen by the caller,
>> > is seconds. The underlying logic receives the input and multiplies it
>> > by 1000 in qmp_migrate_set_downtime().
>> 
>> Yes, QMP migrate_set_downtime takes seconds, but I'm talking about QMP
>> command migrate-set-parameters, which takes milliseconds.
>> 
>> >> I'm afraid you need to fix the error message in
>> >> qmp_migrate_set_downtime().  If you assume qmp_migrate_set_parameters()
>> >> fails only in one way, replace its error object by one with a better
>> >> message[*].  If you'd rather not assume, you need to refactor things so
>> >> that each place can set the downtime and create an appropriate error on
>> >> failure.
>> >
>> > There is at least one similar usage of this error message just
>> > above this code in max_bandwidth param. Perhaps a new
>> > function/macro to deal with these cases is justified.
>> >
>> >>
>> >> We might want to check other command wrappers that translate units.
>> >>
>> >> Time units are a hopeless mess in QMP.  We should've enforced uniform
>> >> usage of either seconds or nanoseconds.  The latter to placate
>> >> irrational fear of floating-point[**].
>> >
>> > I agree that my patch doesn't make it much better. I just set the
>> > error message to be in seconds to be consistent with the user input,
>> 
>> That's reasonable!  The problem is that you fix one error message by
>> breaking another one.
>> 
>> > but the code now feels 'awkward' when you do a verification
>> > in milliseconds and deliver the error message in seconds.
>> >
>> > One thing that can be done is to make migrate-set-downtime to
>> > accept milliseconds instead of seconds. I wasn't willing at first to
>> > change the migrate-set-downtime API because of an error
>> > message, however it really feels like the right thing to do here.
>> 
>> Changing QMP commands incompatibly is a big no-no.
>> 
>> > Specially when you consider that the default value of this parameter,
>> > set by DEFAULT_MIGRATE_SET_DOWNTIME, is 300 - a value that
>> > in theory the user shouldn't be able to set in the API.
>> 
>> I think that's a fine reason for deprecating the migrate_set_downtime
>> command, and ask people to use migrate-set-parameters instead.
>
> OK, but you can set it to 300 from migrate_set_downtime by doing
> HMP:
>    migrate_set_downtime 0.3 
> QMP:
>    { "execute": "migrate_set_downtime", "arguments": { "value": 0.3 } }
>
> so it's bogus to say that's a reason to ditch it.

I bought Daniel's assertion without checking it.  Thanks for the
correction.

> This has all got rather complex for a simple patch to change an error
> message.  Can't we just come up with a clear error message that works in
> all cases.

I outlined how to fix migrate_set_downtime's error message without
breaking migrate-set-parameters's in my review.

If we can come up with a single message that works for both commands,
even better.

>
> Dave
>
>> >> [*] If replacing messages turns out to be a common operation, we can add
>> >> a function to replace it within the same Error object.
>> >>
>> >> [**] If you think the rounding you can get when converting
>> >> floating-point seconds to integer milli-, micro- or nanoseconds matters,
>> >> I have time-keeping equipment to sell you.
>> >>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
