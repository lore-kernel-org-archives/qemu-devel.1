Received: from eggs.gnu.org ([2001:4830:134:3::10]:37212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQvHc-0004IL-JJ
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:48:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQvHb-00027W-Or
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:48:56 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180529174821.19964-1-f4bug@amsat.org>
Date: Thu, 07 Jun 2018 15:48:47 +0200
In-Reply-To: <20180529174821.19964-1-f4bug@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue,
	29 May 2018 14:48:17 -0300")
Message-ID: <87lgbqvha8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] qapi/error: converts
 error_setg(&error_fatal) to error_report() + exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Hi,
>
> This series converts error_setg(&error_fatal) to error_report() + exit() =
as
> suggested by the "qapi/error.h" documentation.

Appreciated!

The series actually converts two anti-patterns.

1. From

    if (COND) {
        error_setg(&error_fatal, ...);
    }

to

    if (COND) {
        error_report(...);
        exit(1);
    }

This is exactly what error.h asks for.

2. From

    if (COND) {
        error_setg(&error_abort, ...);
    }
to

    if (COND) {
        error_report(...);
        abort();
    }

error.h asks for

    assert(!COND);

instead.  See my reply to PATCH 1 for why.
