Received: from eggs.gnu.org ([2001:4830:134:3::10]:56575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1e0L7Q-0001jv-Bo
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 01:24:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1e0L7N-000083-8c
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 01:24:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1e0L7N-00007l-2Q
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 01:24:13 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
	<20171002152552.27999-3-armbru@redhat.com>
	<c3221525-70bc-475d-07c0-bbf47b507e5e@redhat.com>
Date: Fri, 06 Oct 2017 07:24:07 +0200
In-Reply-To: <c3221525-70bc-475d-07c0-bbf47b507e5e@redhat.com> (Eric Blake's
	message of "Thu, 5 Oct 2017 09:58:38 -0500")
Message-ID: <87k208alxk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH 02/32] texi2pod: Support @verbatim
 environment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 10/02/2017 10:25 AM, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  scripts/texi2pod.pl | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> My perl is a bit rusty, but I think I can handle this one.
>
>> 
>> diff --git a/scripts/texi2pod.pl b/scripts/texi2pod.pl
>> index 39ce584a32..2171f8b819 100755
>> --- a/scripts/texi2pod.pl
>> +++ b/scripts/texi2pod.pl
>> @@ -85,6 +85,13 @@ if (defined $out) {
>>  
>>  while(defined $inf) {
>>  while(<$inf>) {
>> +    # Verbatim environment
>> +    if (defined $endw and $endw eq "verbatim"
>> +	and not (/^\@end\s+([a-z]+)/ and $1 eq $endw)) {
>
> You anchored to the beginning, but not the end, of the line; that means
> you accept '@end verbatim garbage' as an end marker.  Worth adding $?

Cribbed from

    # End-block handler goes up here because it needs to operate even
    # if we are skipping.
    /^\@end\s+([a-z]+)/ and do {
	# Ignore @end foo, where foo is not an operation which may
	# cause us to skip, if we are presently skipping.
	my $ended = $1;
	next if $skipping && $ended !~ /^(?:ifset|ifclear|ignore|menu|iftex|copying)$/;

	die "\@end $ended without \@$ended at line $.\n" unless defined $endw;
	die "\@$endw ended by \@end $ended at line $.\n" unless $ended eq $endw;

	$endw = pop @endwstack;

I'd prefer to stick to this regexp.

texi2pod.pl parses quite sloppily in general.

> If that's the only change, I'm okay with adding:
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Does this apply to the unchanged patch, too?
