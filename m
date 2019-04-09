Received: from eggs.gnu.org ([209.51.188.92]:42578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDjx7-0008Un-HS
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 02:09:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDjx6-0003Jl-IG
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 02:09:49 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-3-armbru@redhat.com>
	<3d4cd6c6-49f0-daad-bb1b-25a2456f740f@redhat.com>
Date: Tue, 09 Apr 2019 08:09:43 +0200
In-Reply-To: <3d4cd6c6-49f0-daad-bb1b-25a2456f740f@redhat.com> (Eric Blake's
	message of "Mon, 8 Apr 2019 14:13:08 -0500")
Message-ID: <8736mriuag.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 02/15] block/ssh: Do not report
 read/write/flush errors to the user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> On 4/8/19 3:36 AM, Markus Armbruster wrote:
>> Callbacks ssh_co_readv(), ssh_co_writev(), ssh_co_flush() report
>> errors to the user with error_printf().  They shouldn't, it's their
>> caller's job.  Replace by a suitable trace point.
>> 
>> Perhaps we should convert this part of the block driver interface to
>> Error, so block drivers can pass more detail to their callers.  Not
>> today.
>> 
>> Cc: "Richard W.M. Jones" <rjones@redhat.com>
>> Cc: Kevin Wolf <kwolf@redhat.com>
>> Cc: Max Reitz <mreitz@redhat.com>
>> Cc: qemu-block@nongnu.org
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  block/ssh.c        | 36 ++++++++++++------------------------
>>  block/trace-events |  3 +++
>>  2 files changed, 15 insertions(+), 24 deletions(-)
>> 
>
>> -static void GCC_FMT_ATTR(2, 3)
>> -sftp_error_report(BDRVSSHState *s, const char *fs, ...)
>> +static void sftp_error_trace(BDRVSSHState *s, const char *op)
>>  {
>> -    va_list args;
>> +    char *ssh_err;
>> +    int ssh_err_code;
>> +    unsigned long sftp_err_code;
>>  
>> -    va_start(args, fs);
>> -    error_vprintf(fs, args);
>> -
>> -    if ((s)->sftp) {
>
> The old code was conditional,
>
>> -        char *ssh_err;
>> -        int ssh_err_code;
>> -        unsigned long sftp_err_code;
>> -
>> -        /* This is not an errno.  See <libssh2.h>. */
>> -        ssh_err_code = libssh2_session_last_error(s->session,
>> +    /* This is not an errno.  See <libssh2.h>. */
>> +    ssh_err_code = libssh2_session_last_error(s->session,
>>                                                    &ssh_err, NULL, 0);
>
> Indentation looks off now.

Will fix.

>> -        /* See <libssh2_sftp.h>. */
>> -        sftp_err_code = libssh2_sftp_last_error((s)->sftp);
>> +    /* See <libssh2_sftp.h>. */
>> +    sftp_err_code = libssh2_sftp_last_error((s)->sftp);
>
> but it appears the new code can call libssh2_sftp_last_error(NULL). Am I
> missing something, or could that be a problem?
>
> /me rescans the full file...
>
> Okay, connect_to_ssh() won't succeed unless s->sftp is set, and it
> appears that all callers to the trace function can only be reached if
> connect succeeded.

I can add to the commit message

    While there, drop the unreachable !s->sftp case.

> Indentation fixup can be done by maintainer,
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
