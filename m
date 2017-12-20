Received: from eggs.gnu.org ([2001:4830:134:3::10]:42967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRfbm-0002qE-Dt
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 09:44:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eRfbi-0005cf-5V
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 09:44:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:63591)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eRfbh-0005c0-SD
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 09:44:30 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B8677C058ED7
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 14:44:28 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20171218144145.13579-1-famz@redhat.com>
	<87r2rqg5ac.fsf@dusky.pond.sub.org> <20171220063056.GA3735@lemon>
	<87efnpdb0v.fsf@dusky.pond.sub.org> <20171220093055.GA10812@lemon>
Date: Wed, 20 Dec 2017 15:44:23 +0100
In-Reply-To: <20171220093055.GA10812@lemon> (Fam Zheng's message of "Wed, 20
	Dec 2017 17:30:55 +0800")
Message-ID: <87zi6d8nnc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC] error: Include hint everywhere
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org

Fam Zheng <famz@redhat.com> writes:

> On Wed, 12/20 10:05, Markus Armbruster wrote:
>> Fam Zheng <famz@redhat.com> writes:
>> 
>> > On Tue, 12/19 15:29, Markus Armbruster wrote:
>> >> Adding Eric for additonal QMP design expertise.
>> >> 
>> >> Fam Zheng <famz@redhat.com> writes:
>> >> 
>> >> > Previously we only print hint lines if we are in a command line context
>> >> > or HMP. However QMP errors are also eventually consumed by human and the
>> >> > hint could help.
>> >> >
>> >> > Append hint lines already in error_get_pretty() and do as said above
>> >> > consistently in CLI, HMP and QMP.
>> >> >
>> >> > Signed-off-by: Fam Zheng <famz@redhat.com>
>> >> 
>> >> Problematic.
>> >> 
>> >> The intended use of the "hint" feature is to add hints on the *human*
>> >> user interface.  These need not make sense for QMP, which has different
>> >> syntax.  Please see
>> >> http://lists.gnu.org/archive/html/qemu-devel/2017-08/msg01991.html
>> >> (which I let fall through the cracks, sorry about that).
>> >> 
>> >> In practice, we've been using / abusing the feature for other purposes,
>> >> too, i.e. hints that do make sense for QMP.
>> >> 
>> >> If we decide we want to transmit such hints via QMP, we need to decide
>> >> how to (more on that below), and we need to examine the existing hints
>> >> one by one to decide whether they make sense for QMP.
>> >> 
>> >> If we determine that all of the existing hints make sense for QMP, and
>> >> expect that all future hints will, then we can repurpose
>> >> error_append_hint().  Else, we need two functions, one for each kind of
>> >> hint.
>> >> 
>> >> On to QMP design.  Quote qmp-spec.txt:
>> >> 
>> >>     2.4.2 error
>> >>     -----------
>> >> 
>> >>     The format of an error response is:
>> >> 
>> >>     { "error": { "class": json-string, "desc": json-string }, "id": json-value }
>> >> 
>> >>      Where,
>> >> 
>> >>     - The "class" member contains the error class name (eg. "GenericError")
>> >>     - The "desc" member is a human-readable error message. Clients should
>> >>       not attempt to parse this message.
>> >>     - The "id" member contains the transaction identification associated with
>> >>       the command execution if issued by the Client
>> >> 
>> >> Your patch changes "desc" from a short(ish) message without newline to a
>> >> multi-line message that may or may not end with a newline (I think).
>> >> Is that a good idea?
>> >
>> > Hmm, I didn't pay attention to the ending '\n', you are right we should keep it
>> > consistent.
>> >
>> > Multiline is not a big problem IMO. Because, I'm inclined to think that for
>> > GenericError errors, desc are not for machines; the desc content is not part of
>> > the API and we are free to update it.
>> 
>> "desc" being a short(ish) message without newline is de facto ABI.
>> A management application that logs messages could well be upset by a
>> switch to multiline.
>> 
>> A simple example is a log file consisting of lines with a fixed prefix
>> followed by free-form text.  Code writing such a log needs to be
>> prepared for newlines in free-form text, or else you'll get things like
>> 
>>     Dec 20 09:20:54 Some log entry
>>     Dec 20 09:24:14 Error message
>>     First line of hint
>>     Second line of hint
>>     Dec 20 10:01:05 Some other log entry
>> 
>> Two hint lines do not conform to the format.  Except when their text
>> matches the fixed format, but that's even worse, because then you can't
>> even identify the start of messages reliably.
>
> OK, if "no newline in desc" is the rule, then this doesn't work.

It's not a written rule.  I might be excessively cautious.

>> > That said, the case where my patch would be inappropriate is when the error
>> > comes from a libvirt misconfiguration but the error message is QEMU-specific and
>> > doesn't make sense in a libvirt (abstraction) context.
>> >
>> > So you are probably right we still need to distinguish them in the QMP level.
>> >
>> > Maybe the right thing to do is just convert any error_append_hint() to an
>> > updated error_setg() and already include the "hint" in the error message proper.
>> > So that we can document that error_append_hint() is specifically used for the
>> > case said above, for example.
>> 
>> I'm not sure I understand what you're proposing to do.
>
> For example, change error_append_hint() callers in this pattern:
>
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 36ee89e940..a542479c95 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -703,11 +703,10 @@ static int raw_check_lock_bytes(BDRVRawState *s,
>              if (ret) {
>                  char *perm_name = bdrv_perm_names(p);
>                  error_setg(errp,
> -                           "Failed to get shared \"%s\" lock",
> +                           "Failed to get shared \"%s\" lock. "
> +                           "Is another process using the image?",
>                             perm_name);
>                  g_free(perm_name);
> -                error_append_hint(errp,
> -                                  "Is another process using the image?\n");
>                  return ret;
>              }
>          }

An error message should be a short phrase.  Multiple sentences are an
anti-pattern.

However, this particular one could perhaps be "Failed to get shared
\"%s\" lock (is another process using the image?)".  Might be pushing
"short" beyond its limit.

>> >> The conservative way to add hints is a new optional member.
>> >
>> > I don't like that because it leaves the decision for how to handle the optional
>> > information to the management layer, which, again, may not have the right
>> > information (whether displaying the message to users makes any sense).
>> 
>> Whether we encode error message and hint in a single string separated by
>> the first newline, or in two strings doesn't really change this problem,
>> does it?
>
> On this, my idea is above. As the author of the --- code in the diff I'm fine
> with doing that given what the current error API does on QMP and that people
> complains when they don't see the hint from libvirt error message.
>
> So what I'm trying to say is that I think some messages added by
> error_append_hint() are worth exposing in QMP as well, and some are not. Do we
> want some wider changes somewhere rather than the above diff?

Quoting myself:

    If we decide we want to transmit [...] hints via QMP, we need to
    decide how to (more on that below), and we need to examine the
    existing hints one by one to decide whether they make sense for QMP.

In other words:

0. Pick a name other than "hint" for this kind of hint, to avoid future
confusion.

1. Extend QMP error wire format to carry it

2. Create a C interface to add it

3. Convert existing error_append_hint() to it, where appropriate
