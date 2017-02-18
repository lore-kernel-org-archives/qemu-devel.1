Received: from eggs.gnu.org ([2001:4830:134:3::10]:56322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cf1wc-0006SW-Mk
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 05:08:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cf1wX-0002mo-NG
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 05:08:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cf1wX-0002mg-Hy
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 05:08:41 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8B03DC057FAC
	for <qemu-devel@nongnu.org>; Sat, 18 Feb 2017 10:08:41 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-15-git-send-email-armbru@redhat.com>
	<40e2f699-6ae7-fc82-1d71-25a7a35a11c2@redhat.com>
Date: Sat, 18 Feb 2017 11:08:38 +0100
In-Reply-To: <40e2f699-6ae7-fc82-1d71-25a7a35a11c2@redhat.com> (Eric Blake's
	message of "Fri, 17 Feb 2017 14:44:07 -0600")
Message-ID: <8737fb7qvt.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 14/24] util/cutils: New
 qemu_strtosz_metric()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 02/14/2017 04:26 AM, Markus Armbruster wrote:
>> To parse numbers with metric suffixes, we use
>> 
>>     qemu_strtosz_suffix_unit(nptr, &eptr, QEMU_STRTOSZ_DEFSUFFIX_B, 1000)
>> 
>> Capture this in a new function for legibility:
>> 
>>     qemu_strtosz_metric(nptr, &eptr)
>> 
>> Replace test_qemu_strtosz_suffix_unit() by test_qemu_strtosz_metric().
>> 
>> Rename qemu_strtosz_suffix_unit() to do_strtosz() and give it internal
>> linkage.
>
> I don't know if you do this later, but coreutils (via gnulib) has a nice
> convention that:
>
> 1k   => 1024
> 1kB  => 1000
> 1kiB => 1024
>
> where the suffix can be used to express metric or power-of-two, letting
> the user choose which scale they want rather than hard-coding the scale.

Could be done for the calls that currently pass 1024, because the
existing one-character suffixes keep their meaning there.  Would be an
incompatible change for the calls that pass 1000.  There's just one
outside of tests, and it's a frequency value, i.e. 'k' makes sense, but
'kB' and 'kiB' do not.

>  But implementing that is beyond this scope of this particular patch.

Indeed.

>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>> @@ -251,7 +251,7 @@ fail:
>>  int64_t qemu_strtosz_suffix(const char *nptr, char **end,
>>                              const char default_suffix)
>>  {
>> -    return qemu_strtosz_suffix_unit(nptr, end, default_suffix, 1024);
>> +    return do_strtosz(nptr, end, default_suffix, 1024);
>>  }
>>  
>>  int64_t qemu_strtosz(const char *nptr, char **end)
>> @@ -259,6 +259,11 @@ int64_t qemu_strtosz(const char *nptr, char **end)
>>      return qemu_strtosz_suffix(nptr, end, QEMU_STRTOSZ_DEFSUFFIX_MB);
>
> Do you also want to convert this one to do_strtosz() to avoid
> double-forwarding?

See next patch :)

> Either way,
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
