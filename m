Received: from eggs.gnu.org ([209.51.188.92]:32843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGoAm-0002y0-0B
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:16:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGoAl-0004BO-4M
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:16:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hGoAk-00049o-ST
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:16:35 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190416153850.5186-1-armbru@redhat.com>
Date: Wed, 17 Apr 2019 19:16:31 +0200
In-Reply-To: <20190416153850.5186-1-armbru@redhat.com> (Markus Armbruster's
	message of "Tue, 16 Apr 2019 17:38:50 +0200")
Message-ID: <878sw8wo0g.fsf@dusky.pond.sub.org>
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
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, Eric Blake <eblake@redhat.com>

Markus Armbruster <armbru@redhat.com> writes:

> Before the from qerror_report() to error_setg(), hints looked like
> this:
>
>     qerror_report(QERR_MACRO, ... arguments ...);
>     error_printf_unless_qmp(... hint ...);
>
> error_printf_unless_qmp() made perfect sense: it printed exactly when
> qerror_report() did.
>
> After the conversion to error_setg():
>
>     error_setg(errp, QERR_MACRO, ... arguments ...);
>     error_printf_unless_qmp(... hint ...);
>
> The "unless QMP part" still made some sense; in QMP context, the
> caller generally uses the error as QMP response instead of printing
> it.
>
> However, everything else is wrong.  If the caller handles the error,
> the hint gets printed anyway (unless QMP).  If the caller reports the
> error, the hint gets printed *before* the report (unless QMP) or not
> at all (if QMP).
>
> Commit 50b7b000c91 fixed this by making hints a member of Error.  It
> kept printing hints with error_printf_unless_qmp():
>
>      void error_report_err(Error *err)
>      {
> 	 error_report("%s", error_get_pretty(err));
>     +    if (err->hint) {
>     +        error_printf_unless_qmp("%s\n", err->hint->str);
>     +    }
> 	 error_free(err);
>      }
>
> This is wrong.  We should (and now can) print the hint exactly when we
> print the error.
>
> The mistake has since been copied to warn_report_err().
>
> Fix both to use error_printf().
>
> Reported-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Cc: Eric Blake <eblake@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Queued.
