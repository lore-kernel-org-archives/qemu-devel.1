Received: from eggs.gnu.org ([209.51.188.92]:47442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hEZxX-0004Ma-1i
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 09:41:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hEZxW-0001dR-3T
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 09:41:42 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1df28c23-7efe-310d-2955-432b9a4bb1ad@redhat.com>
References: <cover.1551895813.git.berto@igalia.com>
	<e25b416f8646a476017f21a8484a05931b0e3f5a.1551895814.git.berto@igalia.com>
	<1df28c23-7efe-310d-2955-432b9a4bb1ad@redhat.com>
Date: Thu, 11 Apr 2019 15:41:38 +0200
Message-ID: <w515zrkveul.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 13/13] qemu-iotests: Test the
 x-blockdev-reopen QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Wed 10 Apr 2019 07:03:50 PM CEST, Max Reitz wrote:
>> +        # hd0 has no backing file: we can omit the 'backing' option
>> +        self.reopen(opts)
>
> [...]
>
>> +        # Detach hd2 from hd0.
>> +        self.reopen(opts, {'backing': None})
>> +        self.reopen(opts, {}, "backing is missing for 'hd0'")
>
> I don=E2=80=99t understand the second test.  hd0 has no default backing f=
ile
> and it currently has no backing child attached to it.  Why would this
> call fail now?

I think there's a bug.

Calling x-blockdev-reopen without 'backing' should only fail if

 a) the image has a backing file attached to it.
    In this case it doesn't: we just detached it in the previous line.

 b) there's a default backing file written on the image header.
    In this case there isn't (hd0 is created without one in setUp()).

So it should not fail. I think the bug is that the test for condition
(b) in bdrv_reopen_prepare() that returns "backing is missing..." is
using backing_file but it should use (correct me if I'm wrong)
auto_backing_file.

Changing that and replacing the test line with self.reopen(opts) fixes
it for me.

Not directly related to this, but should bdrv_backing_detach() also
clear backing_file ?

Berto
