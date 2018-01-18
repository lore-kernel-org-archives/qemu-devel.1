Received: from eggs.gnu.org ([2001:4830:134:3::10]:57751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ec8vF-0000Mq-70
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:04:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ec8vC-0000Xo-46
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:03:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32625)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ec8vB-0000XQ-S9
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:03:54 -0500
References: <20180118025245.13042-1-famz@redhat.com>
	<d1dd1750-c487-be35-05eb-ffb12f18e805@redhat.com>
	<a81a812f-065c-e8be-0d6d-92525a379a82@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cf2b427d-a8a0-a124-16dd-598d4f7eea46@redhat.com>
Date: Thu, 18 Jan 2018 13:03:43 +0100
MIME-Version: 1.0
In-Reply-To: <a81a812f-065c-e8be-0d6d-92525a379a82@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scsi-generic: Simplify error handling code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On 18/01/2018 12:21, Philippe Mathieu-Daud=C3=A9 wrote:
>> I'm not a fan of bool return types, in general (because "!" is often
>> success while "< 0" is failure) and especially when there is an Error*=
*;
>> I disagree with commit 9d3b155186.  But the function is not in an area=
 I
>> maintain so I'm queuing this, thanks.
> Do you prefer "if (local_err)" and "if (errp && *errp)" ?

The latter is wrong.  I do prefer

    if (local_err) {
        error_propagate(errp, local_err);
        return;
    }

or maybe (but only if there is a meaning to a zero vs. positive return
value, or if errno is an important part of the returned Error *)

    ret =3D f(..., errp);
    if (ret < 0) {
        return;
    }

> I wondered once if a macro might improve this pattern but thought the
> code would get more obscure.

Eduardo had a series to avoid error_propagate, where NULL was replaced
by a (non-NULL) IGNORED_ERRORS macro.  Then you could do:

    f(..., errp);
    if (error_is_set(errp)) {
        return;
    }

See here:
https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg03139.html

Paolo
