Received: from eggs.gnu.org ([2001:4830:134:3::10]:42331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fFelR-0004Q4-4y
	for qemu-devel@nongnu.org; Mon, 07 May 2018 07:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fFelO-0003vr-3K
	for qemu-devel@nongnu.org; Mon, 07 May 2018 07:57:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56968 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fFelN-0003v7-UK
	for qemu-devel@nongnu.org; Mon, 07 May 2018 07:57:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5CA55818F6E7
	for <qemu-devel@nongnu.org>; Mon,  7 May 2018 11:57:01 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1525453270-23074-1-git-send-email-thuth@redhat.com>
	<f7756c7c-338a-a719-7135-aa7a53a62c4c@redhat.com>
	<87wowgyqj8.fsf@dusky.pond.sub.org>
	<32c5b770-3bbf-e9d2-ea78-023986ba828f@redhat.com>
	<87sh73yk3z.fsf@dusky.pond.sub.org>
	<ff5d2f93-8629-bc78-73a5-c3af38409647@redhat.com>
Date: Mon, 07 May 2018 13:56:56 +0200
In-Reply-To: <ff5d2f93-8629-bc78-73a5-c3af38409647@redhat.com> (Paolo
	Bonzini's message of "Mon, 7 May 2018 13:02:02 +0200")
Message-ID: <87tvrjvfuf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/5] Removal of deprecated -no-kvm*
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 07/05/2018 09:56, Markus Armbruster wrote:
>>>>> I'm not that sure anymore about -no-kvm.  It can come in handy for
>>>>> distros (*cough* RHEL *cough) that only ship a qemu-kvm binary with
>>>>> default accelerator "-machine accel=3Dkvm:tcg".
>>>>>
>>>>> Yeah, "-accel tcg" is only a few characters later, but it is a
>>>>> relatively recent addition.
>>>>
>>>> 2012 is "relatively recent" in the alternate RHEL universe, perhaps :)
>>>
>>> That was the "-machine accel=3Dtcg", but Paolo was rather talking about
>>> "-accel tcg", which has been added last year. Yes, we've got three (!)
>>> ways of dealing with accelerators now: "-M accel=3D", "-accel" and
>>> "-enable-kvm + -no-kvm". We're very userfriendly, aren't we? ;-)
>>
>> Ugh.  Apparently, vl.c still is a playground without adult supervision.
>
> I'm not sure I get it... "-accel" was added in order to provide
> accelerator options.  If anything, "-machine accel" (added back in 2010)
> is the one that makes little sense these days.

Adding more and more ways to do the same stuff does not improve an
interface.  Interface design needs to be *opinionated*.  If we decide
-machine accel=3Dtcg isn't a nice interface, by all means create a better
one, but as replacement[*], not as addition.

Furthermore:

    tcg: add options for enabling MTTCG

    We know there will be cases where MTTCG won't work until additional work
    is done in the front/back ends to support. It will however be useful to
    be able to turn it on.

    As a result MTTCG will default to off unless the combination is
    supported. However the user can turn it on for the sake of testing.

    Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
    [AJB: move to -accel tcg,thread=3Dmulti|single, defaults]
    Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
    Reviewed-by: Richard Henderson <rth@twiddle.net>

I'm sorry, but this us sub-par.  Yes, the commit is also about "enabling
MTTCG", but it also adds a new way to select accelerators, without ever
spelling that out.  It should've been split, and properly described.


[*] Replacements generally involve deprecation and a grace period.
