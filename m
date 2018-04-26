Received: from eggs.gnu.org ([2001:4830:134:3::10]:54495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBlYR-0001m5-VD
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 14:23:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBlYO-0000y6-GB
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 14:23:39 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:42706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBlYO-0000xO-5W
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 14:23:36 -0400
From: Ian Jackson <ian.jackson@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23266.6436.510186.195469@mariner.uk.xensource.com>
Date: Thu, 26 Apr 2018 19:23:32 +0100
In-Reply-To: <d78d25c0-3259-6f71-34f7-321140b87c69@redhat.com>
References: <1524761612-5307-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524761612-5307-2-git-send-email-ian.jackson@eu.citrix.com>
	<f9d7f1bd-2ef2-691a-fa98-129ecca06b02@redhat.com>
	<23266.3384.611703.928502@mariner.uk.xensource.com>
	<d78d25c0-3259-6f71-34f7-321140b87c69@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/7] error reporting: Introduce
 errnoval parameter to vreport
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, "Daniel =?iso-8859-1?Q?P.Berrang=E9?=" <berrange@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Markus Armbruster <armbru@redhat.com>

Eric Blake writes ("Re: [RFC PATCH 1/7] error reporting: Introduce errnoval parameter to vreport"):
> On 04/26/2018 12:32 PM, Ian Jackson wrote:
> > But, 0 might be fed to strerror.  This is not normally deliberate, but
> > it does occor.  It is not unusual for people to write code which can
> > feed 0 to strerror.  strerror then conventionally returns "Error 0".
> 
> No, POSIX requires:
> http://pubs.opengroup.org/onlinepubs/9699919799/functions/strerror.html
> "if the value of errnum is zero, the message string shall either be an
> empty string or indicate that no error occurred;"
> 
> and at least in glibc, strerror(0) returns "Success", which looks dumb
> in an error message.

I agree that it looks dumb.  About as dumb as "Error 0".

> > I think it is more important not to turn inintended situations where 0
> > would previously have been passed to strerror, into situations where
> > the errno value string simply vanishes.
> 
> Passing 0 as an errno value to indicate an error is almost always wrong.
> But if you don't have an errno value to report, having the error string
> disappear is preferable to outputting garbage or even assert()ing that
> the error value was nonzero.

"Success" is not garbage.

> You are correct that in the past, we've had code passing or returning
> the wrong sign without realizing it.  So the question is whether, at
> least for reporting purposes, it looks better to report "Operation not
> permitted" instead of "Unknown error -1", or whether munging the error
> message as a convenience for better output makes it harder for the
> programmer to realize that they are returning the wrong sign up the
> stack to the caller.

I think in both the above bug cases it is preferable to continue to
print an errno value message, and to print one which indicates that
there is a bug in the program's error handling.

In ordinary code it is not common to want to print an error message
with an error code which is an augmented errno value type containing a
sentinel.  Using 0 as a sentinel for this purpose would mostly
disguise bugs rather than be a convenience.

If you disapprove of the use of -1 as the internal sentinel because of
the possibility of -errno confusion bugs, we could use INT_MIN as the
sentinel.

Ian.
