Received: from eggs.gnu.org ([209.51.188.92]:36819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGTkV-0000fZ-JS
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 15:28:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGTkU-0007zh-Lv
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 15:28:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hGTkU-0007yo-Dn
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 15:28:06 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190416153850.5186-1-armbru@redhat.com>
	<5ee06a0b-90bc-602d-5ee3-3bb3f80f2f6c@redhat.com>
Date: Tue, 16 Apr 2019 21:28:00 +0200
In-Reply-To: <5ee06a0b-90bc-602d-5ee3-3bb3f80f2f6c@redhat.com> (Eric Blake's
	message of "Tue, 16 Apr 2019 10:50:41 -0500")
Message-ID: <87h8ax3g3j.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] error: Fix error_report_err(),
 warn_report_err() hint printing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com

Eric Blake <eblake@redhat.com> writes:

> On 4/16/19 10:38 AM, Markus Armbruster wrote:
>> Before the from qerror_report() to error_setg(), hints looked like
>
> s/the from/the change from/
>
>> this:
>> 
>>     qerror_report(QERR_MACRO, ... arguments ...);
>>     error_printf_unless_qmp(... hint ...);
>> 
>> error_printf_unless_qmp() made perfect sense: it printed exactly when
>> qerror_report() did.
>> 
>> After the conversion to error_setg():
>
> Commit id?

Many.  From the cover letter of the series that finally killed
qerror_report: "After a bit over a year and many patches, QError is
finally ripe."

Here are two known to have messed up hints (commit 50b7b000c91 says so):

7216ae3d1a11e07192623ad04d450e98bf1f3d10
d282842999b914c38c8be4659012aa619c22af8b

>> 
>>     error_setg(errp, QERR_MACRO, ... arguments ...);
>>     error_printf_unless_qmp(... hint ...);
>> 
>> The "unless QMP part" still made some sense; in QMP context, the
>> caller generally uses the error as QMP response instead of printing
>> it.
>> 
>> However, everything else is wrong.  If the caller handles the error,
>> the hint gets printed anyway (unless QMP).  If the caller reports the
>> error, the hint gets printed *before* the report (unless QMP) or not
>> at all (if QMP).
>> 
>> Commit 50b7b000c91 fixed this by making hints a member of Error.  It
>
> Belongs to 2.5.0.
>
>> kept printing hints with error_printf_unless_qmp():
>> 
>>      void error_report_err(Error *err)
>>      {
>> 	 error_report("%s", error_get_pretty(err));
>>     +    if (err->hint) {
>>     +        error_printf_unless_qmp("%s\n", err->hint->str);
>>     +    }
>> 	 error_free(err);
>>      }
>> 
>> This is wrong.  We should (and now can) print the hint exactly when we
>> print the error.
>> 
>> The mistake has since been copied to warn_report_err().
>
> Commit id?

e43ead1d0b9c467af4a2af8f5177316a0ccb5602

>> 
>> Fix both to use error_printf().
>> 
>> Reported-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Cc: Eric Blake <eblake@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  util/error.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>
> Probably too late for 4.0-rc4. Then again, it regressed in 2.5, so
> having yet one more release with the lame output doesn't hurt.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
