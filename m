Received: from eggs.gnu.org ([2001:4830:134:3::10]:59082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQuqE-00072N-TK
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:20:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQuqD-0003GS-S9
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:20:38 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180601091835.21620-1-famz@redhat.com>
	<20180601124345.GC3458@redhat.com>
Date: Thu, 07 Jun 2018 15:20:24 +0200
In-Reply-To: <20180601124345.GC3458@redhat.com> ("Daniel P. =?utf-8?Q?Berr?=
	=?utf-8?Q?ang=C3=A9=22's?=
	message of "Fri, 1 Jun 2018 13:43:45 +0100")
Message-ID: <87602uwx5z.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] file-posix: Consolidate the locking error
 message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Jun 01, 2018 at 05:18:35PM +0800, Fam Zheng wrote:
>> When hot-plugging a block device fails due to image locking errors,
>> users won't see the helpful 'Is another process using the image?'
>> message in QMP because currently the error hint is not carried over
>> there.
>>=20
>> Even though extending QMP to include hint is a conceivably easy task,
>> Libvirt will need some change to consume that data.
>>=20
>> Before that is fully sorted out, let's just do the easy fix by joining
>> the two lines.
>
> There are many places in QEMU which uses error hints and these are all
> invisible to libvirt. Arbitrarily picking one hint to remove, while
> leaving everything else unfixed is not a very satisfactory approach.
>
> If QEMU passes the hint in QMP, it is trivial for libvirt to be changed
> to append the hint when reporting its own error message, so can we just
> focus on fixing the root cause instead of special casing file-posix.c

Intended use of hints according to error.h:

 * Intended use is adding helpful hints on the human user interface,
 * e.g. a list of valid values.  It's not for clarifying a confusing
 * error message.

I admit this guidance is widely ignored.

When used as intended, the hints need not make any sense in QMP!
Consider this example in qemu-option.c:

        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name,
                   "a non-negative number below 2^64");
        error_append_hint(errp, "Optional suffix k, M, G, T, P or E means"
                          " kilo-, mega-, giga-, tera-, peta-\n"
                          "and exabytes, respectively.\n");

The suffixes are only available in the human interface.

Aside: we have lots of code consuming input from both QMP and HMP / CLI.
The error reporting is generally atrocious for at least one of the two.

Perhaps we could use separate functions for providing syntax hints and
for clarifying confusing error messages.  Patches welcome, but they
better convert all existing uses.
