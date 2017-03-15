Received: from eggs.gnu.org ([2001:4830:134:3::10]:50189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co3Wv-0007hA-O5
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:39:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co3Wr-0005gs-SM
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:39:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co3Wr-0005gY-Lw
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:39:29 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-32-git-send-email-armbru@redhat.com>
	<bde5a409-92c8-b0b9-178a-a12ddb2ea479@redhat.com>
Date: Wed, 15 Mar 2017 08:39:26 +0100
In-Reply-To: <bde5a409-92c8-b0b9-178a-a12ddb2ea479@redhat.com> (Eric Blake's
	message of "Tue, 14 Mar 2017 15:35:21 -0500")
Message-ID: <87pohjq98x.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.9 31/47] qapi: Fix detection of doc /
 expression mismatch
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

> On 03/13/2017 01:18 AM, Markus Armbruster wrote:
>> This fixes the errors uncovered by the previous commit.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>>  
>>              expr = self.get_expr(False)
>>              if 'include' in expr:
>> +                self.reject_expr_doc()
>>                  if len(expr) != 1:
>
> Do you also need to handle 'pragma' expressions added earlier in the series?

Yes.

> /me goes and experiments:
>
> diff --git i/tests/qapi-schema/doc-bad-expr.json
> w/tests/qapi-schema/doc-bad-expr.json
> index 0caa0ae..6c1204d 100644
> --- i/tests/qapi-schema/doc-bad-expr.json
> +++ w/tests/qapi-schema/doc-bad-expr.json
> @@ -4,4 +4,5 @@
>  # @foo:
>  ##
>  { 'include': 'empty.json' }
> +{ 'pragma': {} }
>  { 'struct': 'foo', 'data': {} }
>
> Oops - back to accepting the program.

Need to squash in

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 1dc33c9..8d55ff4 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -301,6 +301,7 @@ class QAPISchemaParser(object):
                 self._include(include, info, os.path.dirname(abs_fname),
                               previously_included)
             elif "pragma" in expr:
+                self.reject_expr_doc()
                 if len(expr) != 1:
                     raise QAPISemError(info, "Invalid 'pragma' directive")
                 for name, value in expr['pragma'].iteritems():
