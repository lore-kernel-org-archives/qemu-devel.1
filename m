Received: from eggs.gnu.org ([2001:4830:134:3::10]:44956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cjqo9-0006ew-Sw
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 12:15:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cjqo4-0002yt-Ow
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 12:15:57 -0500
References: <20170302122429.7737-1-berrange@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <194be75d-52ae-757f-2dbb-f8f4597cec67@redhat.com>
Date: Fri, 3 Mar 2017 12:15:50 -0500
MIME-Version: 1.0
In-Reply-To: <20170302122429.7737-1-berrange@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qmp: allow setting properties to empty
 string in qmp-shell
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>



On 03/02/2017 07:24 AM, Daniel P. Berrange wrote:
> The qmp-shell property parser currently rejects attempts to
> set string properties to the empty string eg
> 
>   (QEMU) migrate-set-parameters  tls-hostname=
>   Error while parsing command line: Expected a key=value pair, got 'tls-hostname='
> command format: <command-name>  [arg-name1=arg1] ... [arg-nameN=argN]
> 
> This is caused by checking the wrong condition after splitting
> the parameter on '='. The "partition" method will return "" for
> the separator field, if the seperator was not present, so that
> is the correct thing to check for malformed syntax.
> 

Ah, good point.

> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  scripts/qmp/qmp-shell | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
> index 0373b24..eccb88a 100755
> --- a/scripts/qmp/qmp-shell
> +++ b/scripts/qmp/qmp-shell
> @@ -166,8 +166,8 @@ class QMPShell(qmp.QEMUMonitorProtocol):
>  
>      def __cli_expr(self, tokens, parent):
>          for arg in tokens:
> -            (key, _, val) = arg.partition('=')
> -            if not val:
> +            (key, sep, val) = arg.partition('=')
> +            if sep != '=':
>                  raise QMPShellError("Expected a key=value pair, got '%s'" % arg)
>  
>              value = self.__parse_value(val)
> 
