Received: from eggs.gnu.org ([2001:4830:134:3::10]:57769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpcJT-0002GR-L2
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:32:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpcJR-0001xy-TQ
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:32:23 -0400
Date: Wed, 6 Sep 2017 17:32:02 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170906153202.GJ3753@dhcp-200-186.str.redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 00/56] qapi: Use 'size' for byte counts
 & offsets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, jcody@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, jsnow@redhat.com

Am 07.08.2017 um 16:45 hat Markus Armbruster geschrieben:
> Byte sizes, offsets and the like should use QAPI type 'size'
> (uint64_t).  This rule is more honored in the breach than in the
> observance.  Fix the obvious offenders.
> 
> The series is RFC for at least two reasons:
> 
> 1. It's only lightly tested.  Commit message claims like "FOO now
>    works" haven't been verified, yet.
> 
> 2. The block layer represents file offsets and sizes as int64_t in
>    many places.  Must not be negative, except for function return
>    values, where it means failure.
> 
>    If you pass negative values via QMP, things explode.  Rejecting
>    them cleanly would be better, but we do that only haphazardly, as
>    far as I can tell.
> 
>    Changing the QAPI schema from 'int' (C: int64_t) to 'size' (C:
>    uint64_t) arguably makes things slightly worse: you can't
>    reasonably expect negative offsets and sizes to work, but expecting
>    offsets and sizes between 2^63 and 2^64-1 to work is less
>    unreasonable.  The explosions stay the same.
> 
>    Perhaps we should have a dedicated QAPI type for file offsets, just
>    like libc has off_t.  Which is also signed, by the way.

I discussed this a bit on IRC with Markus and I'll just reply here with
some of our findings:

* Having a 63-bit unsigned type makes sense. Not because it's the most
  accurate type for most places and will catch all invalid arguments,
  it's probably still too large in most places and individual function
  needs to keep (or finally introduce) checks for the valid range. But
  compared to 'int' it doesn't allow us to forget the < 0 check, and
  compared to 'uint64' the resulting values are immune to careless
  casting between unsigned and signed C types. These seem to be common
  bugs, so getting rid of them would be nice.

* 'size' is the right type for sizes, offsets, etc. but the problem is
  likely to affect other arguments, too. 'size' enables additional
  syntax in the string visitor, so it is different from the other
  integer types. This means that we probably want both a 63 bit size
  type and a 63 bit plain unsigned integer type.

* 'int' is an alias for (signed) 'int64'. People don't seem to think
  much about using 'int' because it's the simplest type. That doesn't
  make it right to use, though. It may be better to remove the 'int'
  type and force any definitions to be specific about the signedness and
  width they need. My intuitive guess is that most places that use 'int'
  today don't actually want to accept negative numbers.

* Schema introspection doesn't distinguish between integer types, this
  is purely internal, so changing a definition from one integer type to
  another is okay.

Markus, did I forget anything important?

Kevin
